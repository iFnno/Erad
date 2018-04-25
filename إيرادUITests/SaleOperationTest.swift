//
//  SaleOperationTest.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/6/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class SaleOperationTest: XCTestCase {
    
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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaleOperation() {

    }
    func testPauseSlaeOperation() {
        
    }
    func testViewInventory(){
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH\r")
        app.buttons["تسجيل الدخول"].tap()
        app.buttons["بدء وقت العمل"].tap()
        app.navigationBars["قائمة المنتجات"].buttons["inventory"].tap()
        //XCTAssert(app.navigationBars["قائمة المنتجات"].buttons["inventory"].exists)
 }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
