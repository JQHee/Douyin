//
//  UINavigationBar+.swift
//  Douyin
//
//  Created by midland on 2019/1/10.
//

import Foundation

// MARK: - FixSpace
@available(iOS 11.0, *)
extension UINavigationBar {
    static func swizzedMethod()  {
        let originalMethod = class_getInstanceMethod(self, #selector(UINavigationBar.layoutSubviews))
        let swizzledMethod = class_getInstanceMethod(self,  #selector(UINavigationBar.swizzle_layoutSubviews))
        guard let tempOriginalMethod = originalMethod, let tempSwizzledMethod = swizzledMethod else { return }
        method_exchangeImplementations(tempOriginalMethod, tempSwizzledMethod)
    }
    
    @objc func swizzle_layoutSubviews() {
        swizzle_layoutSubviews()
        
        layoutMargins = .zero
        for view in subviews {
            if NSStringFromClass(view.classForCoder).contains("ContentView") {
                view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
}

