//
//  DownloadApiManager.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation


//默认下载保存地址（用户文档目录）
fileprivate let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum DownloadApiManager {
    case downloadFile
}

extension DownloadApiManager: RxMoyaTargetType {
    
    //根据枚举值获取对应的资源文件名
    var assetName: String {
        switch self {
        case .downloadFile: return "logo.png"
        }
    }
    
    //获取对应的资源文件本地存放路径
    var localLocation: URL {
        return assetDir.appendingPathComponent(assetName)
    }
    
    //定义一个DownloadDestination
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var baseURL: URL {
        switch self {
        case .downloadFile:
            return URL.init(string: "http://www.hangge.com")!
        }
    }
    
    var path: String {
        switch self {
        case .downloadFile:
            return "/assets/" + assetName
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .downloadFile:
            return .downloadDestination(downloadDestination)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var cacheKey: String? {
        return ""
    }
    
    var isShowHud: Bool {
        return false
    }
    
    var timeOut: Double {
        return -1
    }
}
