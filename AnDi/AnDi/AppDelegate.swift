//
//  AppDelegate.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import REFrostedViewController

var tabbarCtl: UITabBarController!
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarCtl: UITabBarController!
    var reFrostedViewController: REFrostedViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        configTabbar()
        configREFrostedViewController()
        window?.rootViewController = reFrostedViewController
        window?.makeKeyAndVisible()
        return true
    }

    func configTabbar(){
        tabbarCtl = UITabBarController()

        let homeViewController = HomeViewController()
        let homeTabbar = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 1)
        homeViewController.tabBarItem = homeTabbar
        let navHomeViewController = UINavigationController(rootViewController: homeViewController)

        let notificationViewController = NotificationViewController()
        let notificationTabbar = UITabBarItem(title: "Notification", image: UIImage(named: "notification"), tag: 1)
        notificationViewController.tabBarItem = notificationTabbar
        let navNotificationViewController = UINavigationController(rootViewController: notificationViewController)

        let profileViewController = ProfileViewController()
        let profileTabbar = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 1)
        profileViewController.tabBarItem = profileTabbar
        let navProfileViewController = UINavigationController(rootViewController: profileViewController)

        let moreViewController = MoreViewController()
        let moreTabbar = UITabBarItem(title: "More", image: UIImage(named: "more"), tag: 1)
        moreViewController.tabBarItem = moreTabbar
        let navMoreViewController = UINavigationController(rootViewController: moreViewController)

        let commentViewController = CommentViewController()
        let commentTabbar = UITabBarItem(title: "Report", image: UIImage(named: "report"), tag: 1)
        commentViewController.tabBarItem = commentTabbar
        let navCommentViewController = UINavigationController(rootViewController: commentViewController)

        let arrViewControllers = [navHomeViewController, navNotificationViewController, navProfileViewController, navCommentViewController, navMoreViewController]
        tabbarCtl.viewControllers = arrViewControllers
        tabbarCtl.tabBar.tintColor = UIColor(rgb: kColor)
        tabbarCtl.tabBar.barTintColor = UIColor.white
    }

    func configREFrostedViewController(){
        let menuViewController = MenuViewController()
        reFrostedViewController = REFrostedViewController(contentViewController: tabbarCtl, menuViewController: menuViewController)
        reFrostedViewController?.direction = .left
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

