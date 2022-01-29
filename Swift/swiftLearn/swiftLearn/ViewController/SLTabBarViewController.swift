//
//  SLTabBarViewController.swift
//  swiftLearn
//
//  Created by 19054909 on 2021/6/17.
//

import UIKit

class SLTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewController()
    }
    
    func initViewController() {
        let homeTabBar = UITabBarItem(title: "首页", image:  UIImage(named: "home"), selectedImage: UIImage(named: "home-select"))
        let homeVC = HomeViewController()
        let homeNav = BaseNavigationViewController(rootViewController: homeVC)
        homeNav.tabBarItem = homeTabBar
        
        let discoverTabBar = UITabBarItem(title: "发现", image:  UIImage(named: "discover"), selectedImage: UIImage(named: "discover-select"))
        let discoverVC =  DiscoverViewController()
        let discoverNav = BaseNavigationViewController(rootViewController: discoverVC)
        discoverNav.tabBarItem = discoverTabBar
        
        let mineTabBar = UITabBarItem(title: "我的", image:  UIImage(named: "mine"), selectedImage: UIImage(named: "mine-select"))
        let mineVC =  MineViewController()
        let mineNav = BaseNavigationViewController(rootViewController: mineVC)
        mineNav.tabBarItem = mineTabBar
        
        self.setViewControllers([homeNav,discoverNav,mineNav], animated: true)
    }
}
