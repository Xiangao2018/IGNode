//
//  UIViewController+Node.swift
//  iPhoneGame
//
//  Created by enjoy on 2018/7/21.
//  Copyright © 2018 enjoy. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController: IGNode {
    
    var igHanderable: IGHandlerable? {
        return !self.ignoreIG ? (self as? IGHandlerable) : nil
    }
    
    @objc open var ignoreIG: Bool { return self.presentedViewController != nil }
    
    var firstIGNode: IGNode {
        if let presented = self.presentedViewController {
            return presented.firstIGNode
        } else {
            return currentChildViewController?.firstIGNode ?? self
        }
    }
    
    @objc open var currentChildViewController: UIViewController? {
        return nil
    }
}

extension UINavigationController {
    
    @objc open override var currentChildViewController: UIViewController? {
        return self.topViewController
    }
}

extension UITabBarController {
    
    @objc open override var currentChildViewController: UIViewController? {
        return self.selectedViewController
    }
}

extension UIPageViewController {
    
    @objc open override var currentChildViewController: UIViewController? {
        return self.viewControllers?.first ?? self
    }
}
