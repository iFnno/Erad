//
//  ______UITests.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class ______UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
       
        continueAfterFailure = false
      
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfullLogin() {
     let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        let button = app.buttons["تسجيل الدخول"]
        button.tap()
      //  DispatchQueue.main.async(execute: {
        //    UIApplication.shared.registerForRemoteNotifications()
        //})
        sleep(3)
        XCTAssert(app.buttons["لاحقاً"].exists) }
    
    func testIncorrectLogin() {
        let app = XCUIApplication()
        app.buttons["تسجيل الدخول"].tap()
        XCTAssert(app.alerts["خطأ"].exists)
        }
    
    func testLogout(){
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        app.buttons["تسجيل الدخول"].tap()
        app.buttons["لاحقاً"].tap()
        app.tabBars.buttons["الملف الشخصي"].tap()
        app.buttons["تسجيل الخروج"].tap()
        XCTAssert(emailTextField.exists)
        
    }
   }
