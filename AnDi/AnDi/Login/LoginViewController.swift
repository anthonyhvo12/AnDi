//
//  LoginViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import REFrostedViewController

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!

    @IBOutlet weak var logoImageView: UIImageView!

    var tabbarCtl: UITabBarController!
    var reFrostedViewController: REFrostedViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configLoginButton()
    }

    func configLoginButton(){
        loginButton.layer.cornerRadius = 4
        loginButton.clipsToBounds = true

        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        signupButton.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        logoImageView.layer.cornerRadius = logoImageView.frame.size.width/2
        logoImageView.clipsToBounds = true
    }

    @objc func login(){
        configTabbar()
        configREFrostedViewController()
        self.present(reFrostedViewController, animated: true, completion: nil)
    }

    @objc func createNewAccount(){
        let signupVC = SignupViewController()
        self.present(signupVC, animated: true, completion: nil)
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

        let arrViewControllers = [navHomeViewController, navNotificationViewController, navProfileViewController, navMoreViewController]
        tabbarCtl.viewControllers = arrViewControllers
        tabbarCtl.tabBar.tintColor = UIColor(rgb: kColor)
    }

    func configREFrostedViewController(){
        let menuViewController = MenuViewController()
        reFrostedViewController = REFrostedViewController(contentViewController: tabbarCtl, menuViewController: menuViewController)
        reFrostedViewController?.direction = .left
    }
}
