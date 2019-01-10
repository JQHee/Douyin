//
//  UIApplication+.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation
extension UIApplication {
    private static let classSwizzedMethodRunOnce: Void = {
        if #available(iOS 11.0, *) {
            UINavigationBar.swizzedMethod()
        }
    }()
    
    open override var next: UIResponder? {
        UIApplication.classSwizzedMethodRunOnce
        return super.next
    }
}

