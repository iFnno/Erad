//
//  PersonalProfileTest.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/10/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class PersonalProfileTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.}
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEditAccount() {
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
        let button = app.buttons["تعديل الملف الشخصي"]
        button.tap()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        let textField = element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 3)
        textField.tap()
        textField.typeText("0592125600")
        let button2 = app.buttons["تحديث البيانات"]
        button2.tap()
       XCTAssert(app.alerts["تم التعديل بنجاح"].exists)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
    
        }
    }
    
}
