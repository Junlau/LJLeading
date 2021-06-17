//
//  ViewController.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/5/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    
    //获取 keywindow
    func keywindows() -> UIWindow? {
        for window:UIWindow in UIApplication.shared.windows.reversed() {
            if window.isKind(of: UIWindow.self) && window.windowLevel == UIWindow.Level.normal && window.bounds == UIScreen.main.bounds {
                return window
            }
        }
        return UIApplication.shared.keyWindow
    }
    

}




//获取 keywindow oc
//    NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow *window in [windows reverseObjectEnumerator]) {
//            if ([window isKindOfClass:[UIWindow class]] &&
//                window.windowLevel == UIWindowLevelNormal &&
//                CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
//                return window;
//        }
//        return [UIApplication sharedApplication].keyWindow;
