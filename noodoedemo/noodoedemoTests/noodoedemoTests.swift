//
//  noodoedemoTests.swift
//  noodoedemoTests
//
//  Created by 楊德忻 on 2018/3/2.
//  Copyright © 2018年 sean. All rights reserved.
//

import XCTest
@testable import noodoedemo

class noodoedemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCheckPassword() {
        XCTAssertTrue(Utilities.checkPassword(password:"abtZsq"))
        XCTAssertTrue(Utilities.checkPassword(password:"123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkPassword(password:"0123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkPassword(password:""))
        XCTAssertFalse(Utilities.checkPassword(password:"!~#+"))
    }
    
    func testCheckUsername() {
        XCTAssertTrue(Utilities.checkUsername(username: "123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkUsername(username: "0123456abcdefghijklmnopqrstuvwxyz"))
        XCTAssertFalse(Utilities.checkUsername(username: ""))
        XCTAssertFalse(Utilities.checkUsername(username: "!~#+"))
    }
    
    // WebManager login
    func testLogin() {
        let expectation = self.expectation(description: "Expectation")
        WebManager.sharedManager.login(username: "test2@qq.com", password: "test1234qq", completion: { (data) in
            if data["error"] != nil {
                XCTAssertTrue(false)
            }
            else {
                XCTAssertTrue(true)
            }
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 30) { (exp) in
            
        }
    }
}
