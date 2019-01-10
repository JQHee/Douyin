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
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}

extension SwipeBackBaseViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchButton = touch.view as? UIButton {
            touchButton.isHighlighted = true
        }
        return true
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
        
        return true
    }
    
}

extension SwipeBackBaseViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
}
