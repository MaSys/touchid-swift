//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Yaser Almasri on 10/29/16.
//  Copyright © 2016 MaSys. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginController: UIViewController, UIAlertViewDelegate {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter email"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter password"
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .orange
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        authenticateUser()
    }
    
    func setupViews() {
        
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        _ = logoImageView.anchor(
            view.centerYAnchor, left: nil, bottom: nil, right: nil,
            topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0,
            widthConstant: 160, heightConstant: 160
        )
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(
            logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
            topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32,
            widthConstant: 0, heightConstant: 50
        )
        
        _ = passwordTextField.anchor(
            emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
            topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32,
            widthConstant: 0, heightConstant: 50
        )
        
        _ = loginButton.anchor(
            passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor,
            topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32,
            widthConstant: 0, heightConstant: 50
        )
        
    }
    
    func handleLogin() {
        if (emailTextField.text == "123" && passwordTextField.text == "123") {
            presentHomeController()
        }
        else {
            
        }
    }
    
    func presentHomeController() {
        present(HomeController(), animated: true, completion: nil)
    }
    
    func authenticateUser() {
        let context = LAContext()
        
        var error: NSError?
        
        let reasonString = "Authentication is needed to access your notes."
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, evalPolicyError) -> Void in
                if success {
                    self.presentHomeController()
                }
                else{
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!._code {
                        
                    case LAError.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.userFallback.rawValue:
                        print("User selected to enter custom password")
                        // Enter password manually
                        
                    default:
                        print("Authentication failed")
                        // Enter password manually
                    }
                }
            })]
        }
        else {
            switch error!.code{
                
            case LAError.touchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                
            case LAError.passcodeNotSet.rawValue:
                print("A passcode has not been set")
                
            default:
                print("TouchID not available")
            }
            
            print(error?.localizedDescription)
            // Enter password manually
        }
    }

}












