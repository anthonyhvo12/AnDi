//
//  BaseNavigationViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(pan)
    }

    @objc func panGestureRecognized(sender: UIPanGestureRecognizer){
        self.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
        self.frostedViewController.panGestureRecognized(sender)
    }
    
    func showMenu(){
        self.view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
    }
}
