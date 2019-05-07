//
//  UIViewController+TYSnapshotScroll.swift
//  TYSnapshotScroll-swift
//
//  Created by ma c on 2019/5/7.
//  Copyright © 2019年 ma c. All rights reserved.
//

import UIKit

extension UIViewController{
    class func currentViewController() -> UIViewController? {
        let keyWindow:UIWindow = UIApplication.shared.keyWindow!
        var vc:UIViewController? = keyWindow.rootViewController
        while (vc?.presentedViewController != nil) {
            vc = vc?.presentedViewController!
            if (vc?.isKind(of: UINavigationController.self))!{
                vc = (vc as! UINavigationController).visibleViewController
            }else if (vc?.isKind(of: UITabBarController.self))!{
                vc = (vc as! UITabBarController).selectedViewController
            }
        }

        return vc
    }

}

