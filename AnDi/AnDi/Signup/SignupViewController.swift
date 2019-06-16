//
//  SignupViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var signupButton: UIButton!

    @IBOutlet weak var signinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        signupButton.layer.cornerRadius = 4
        signupButton.clipsToBounds = true
        signupButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
        signinButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func signup(){

    }
}
