//
//  Global.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation
import UIKit
import WebKit
import AdSupport


// 常量
var kScreenFrame: CGRect {
    return UIScreen.main.bounds
}

var kScreenW: CGFloat {
    return UIScreen.main.bounds.width
}

var kScreenH: CGFloat {
    return UIScreen.main.bounds.height
}

var kStaBarH: CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

var kNavBarH: CGFloat {
    return 44.0
}

// 分页加载的数量
var kPageSize: Int {
    return 20
}

// 全局方法
// 获取主线程做相关操作
func dispatch_async_safely_main_queue(_ block: @escaping () -> Void) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}

let UDID: String = ASIdentifierManager.shared().advertisingIdentifier.uuidString

// 全局适配ios 11
func adapterIOS_11() {
    if #available(iOS 11.0, *) {
        // 适配iOS 11的系统
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        // 适配webview底部有黑色块的问题
        WKWebView.appearance().scrollView.contentInsetAdjustmentBehavior = .never
        WKWebView.appearance().isOpaque = false
    }
}
