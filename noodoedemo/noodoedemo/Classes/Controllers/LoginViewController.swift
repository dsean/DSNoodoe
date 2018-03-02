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
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
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
        
        if Utilities.checkUsername(username: self.usernameField.text!) && Utilities.checkPassword(password: self.passwordField.text!) {
            WebManager.sharedManager.login(username: self.usernameField.text!, password: self.passwordField.text!, completion: { [weak self] (data) in
                if data["error"] != nil {
                    
                }
                else {
                    WebManager.sharedManager.sessionToken = data["sessionToken"] as! String
                    print(WebManager.sharedManager.sessionToken)
                }
            })
        }
        else {
            
        }
    }
    
    @IBAction func usernameDidEndONExit(_ sender: UITextField) {
        self.passwordField.becomeFirstResponder()
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
