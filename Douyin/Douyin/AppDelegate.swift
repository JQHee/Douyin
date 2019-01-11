//
//  AppDelegate.swift
//  Douyin
//
//  Created by midland on 2019/1/9.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UserHomePageViewController()
        self.window?.makeKeyAndVisible()
        
        AVPlayerManager.setAudioMode()
        BFRxNetRequest.startMonitoring { (status) in
        }
        WebSocketManger.shared().connect()
        
        visitorLogin()
        
        return true
    }
    
    //
    func visitorLogin() {
        
        let request = VisitorRequest()
        BFRxNetRequest.rx.sendRequest(target: ApiManager.createVisitor(r: request))?
            .subscribe(onNext: { (response) in
                do {
                    let data = try response.filterSuccessfulStatusCodes()
                    let jsonData = try data.mapJSON()
                    print(jsonData)
                    
                } catch let error {
                    let err = error as NSError
                    print(err)
                }
                
        }, onError: { (error) in
            let err = error as NSError
            print(err)
        }).disposed(by: rx.disposeBag)
    }

}

// MARK: - App life cycle
extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}

