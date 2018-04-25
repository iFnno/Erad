//
//  testWorkingShift.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/10/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class WorkingShiftTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        app.buttons["تسجيل الدخول"].tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckin() {
         let app = XCUIApplication()
        app.buttons["بدء وقت العمل"].tap()
        XCTAssert(app.tabBars.buttons["الملف الشخصي"].exists)
    }
    
    func testCheckout() {
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        app.buttons["تسجيل الدخول"].tap()
        app.buttons["بدء وقت العمل"].tap()
        app.tabBars.buttons["الملف الشخصي"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).element(boundBy: 2).tap()
        app.buttons["إنهاء وقت العمل"].tap()
        XCTAssert(app.alerts["إنهاء وقت العمل"].buttons["نعم"].exists)
    }
}
