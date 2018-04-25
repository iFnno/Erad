//
//  ReportTest.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/10/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class ReportTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewReport() {
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        app.buttons["تسجيل الدخول"].tap()
        app.buttons["لاحقاً"].tap()
        XCTAssert(app.tabBars.buttons["التقارير"].exists)
}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
