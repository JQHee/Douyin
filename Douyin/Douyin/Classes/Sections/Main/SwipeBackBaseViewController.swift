//
//  SwipeBackBaseViewController.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import UIKit


// MARK: - System defalut gesture
class SwipeBackBaseViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    private func setupNavBar() {
        let navBar = UINavigationBar.appearance()
        /// 把这个半透明关闭，不然会影响布局
        navBar.isTranslucent = false
        navBar.barTintColor = UIColor.orange
        navBar.barStyle = .black
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        navBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        if viewControllers.count > 0 {
            // 进入新页面隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_titlebar_whiteback"), style: .plain, target: self, action: #selector(backAction))
        }
        
        let backItem = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backItem
        
        super.pushViewController(viewController, animated: animated)
        // 获取tabBar的frame, 如果没有直接返回
        guard var frame = self.tabBarController?.tabBar.frame else {
            return
        }
        // 设置frame的y值, y = 屏幕高度 - tabBar高度
        frame.origin.y = UIScreen.main.bounds.size.height - frame.size.height
        // 修改tabBar的frame
        self.tabBarController?.tabBar.frame = frame
    }
    
}

extension SwipeBackBaseViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchButton = touch.view as? UIButton {
            touchButton.isHighlighted = true
        }
        let point = touch.location(in: self.view)
        return point.x >= 0 && point.x < ceil(UIScreen.main.bounds.size.width) / 3.0
    }
    
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        
        let location = gestureRecognizer.location(in: self.navigationBar)
        if let touchButton = self.navigationBar.hitTest(location, with: nil) as? UIButton,
            touchButton.isDescendant(of: self.navigationBar) {
            touchButton.isHighlighted = false
        }
        
        // 3. 不在转场过程中
        guard let isTransitioning = self.value(forKey: "_isTransitioning") as? NSNumber else { return false }
        return !isTransitioning.boolValue
    }
    
    /// 解决 scrollView 的滑动手势 和 右滑返回手势 冲突问题
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard otherGestureRecognizer is UIPanGestureRecognizer else { return false }
        guard let otherGestureView = otherGestureRecognizer.view as? UIScrollView else { return false }
        guard otherGestureView.bounces && otherGestureView.alwaysBounceHorizontal else { return false }
        return otherGestureView.contentOffset.x <= 0
    }
    
}

extension SwipeBackBaseViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension SwipeBackBaseViewController {
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
