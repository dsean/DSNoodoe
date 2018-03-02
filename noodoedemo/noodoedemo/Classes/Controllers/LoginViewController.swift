//
//  LoginViewController.swift
//  installer
//
//  Created by Sean Yang on 2017/12/28.
//  Copyright © 2017年 qlync. All rights reserved.
//

import Foundation

import UIKit

class LoginViewController: UIViewController {
    
    //Pre-linked with IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageLabel.text = ""
        let imagePassword = UIImageView(image: UIImage(named: "ic_login_password"))
        let imageUsername = UIImageView(image: UIImage(named: "ic_login_uername"))
        self.usernameField.leftViewMode = .always
        self.passwordField.leftViewMode = .always
        self.usernameField.leftView = imageUsername
        self.passwordField.leftView = imagePassword
        
        self.usernameField.text = "test2@qq.com"
        self.passwordField.text = "test1234qq"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
    @IBAction func onTouchLoginButton(_ sender: UIButton) {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        messageLabel.text = "Loading..."
        loginButton.isEnabled = false
        
        // Check input
        if Utilities.checkUsername(username: self.usernameField.text!) && Utilities.checkPassword(password: self.passwordField.text!) {
            
            // Login
            WebManager.sharedManager.login(username: self.usernameField.text!, password: self.passwordField.text!, completion: { [weak self] (data) in
                if data["error"] != nil {
                    DispatchQueue.main.async {
                        self?.messageLabel.text = "Login fail"
                        self?.loginButton.isEnabled = true
                    }
                }
                else {
                    // Update zone
                    WebManager.sharedManager.sessionToken = data["sessionToken"] as! String
                    WebManager.sharedManager.objectId = data["objectId"] as! String
                    WebManager.sharedManager.updateTimeZone(userId: WebManager.sharedManager.objectId, token: WebManager.sharedManager.sessionToken, completion: { [weak self] (data) in
                        DispatchQueue.main.async {
                            if data["error"] != nil {
                                self?.messageLabel.text = "Update fail"
                            }
                            else {
                                self?.messageLabel.text = ""
                                let noDataAlert = UIAlertController(title: "Update success.", message:"", preferredStyle: .alert)
                                noDataAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self?.present(noDataAlert, animated: true, completion: nil)
                            }
                            self?.loginButton.isEnabled = true
                        }
                    })
                }
            })
        }
        else {
            self.messageLabel.text = "Input fail"
            self.loginButton.isEnabled = true
        }
    }
    
    @IBAction func usernameDidEndONExit(_ sender: UITextField) {
        self.passwordField.becomeFirstResponder()
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
