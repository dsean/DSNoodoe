//
//  Utilities.swift
//  installer
//
//  Created by Sean Yang on 2017/12/29.
//  Copyright © 2017年 qlync. All rights reserved.
//

import Foundation


class Utilities: NSObject {

    class func checkUsername (username:String) -> Bool {
        if username.count < 1 || username.count > 32 {
            return false
        }
        
        let mailPattern = "^[a-z0-9._@-]+$"
        let results = Utilities.matches(for: mailPattern, in: username)
        
        if results.count == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    class func checkPassword (password:String) -> Bool {
        if password.count < 1 || password.count > 32 {
            return false
        }
        
        let mailPattern = "^[a-z0-9_-]+$"
        let results = Utilities.matches(for: mailPattern, in: password)
        
        if results.count == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    class func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
