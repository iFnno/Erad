//
//  ReceiptTest.swift
//  إيرادUITests
//
//  Created by Raghad Almojil on 4/10/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import XCTest

class ReceiptTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchforReceipt() {
        
        let app = XCUIApplication()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("asma22@gmail.com")
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("kLY5?yXH")
        app.buttons["تسجيل الدخول"].tap()
        app.buttons["بدء وقت العمل"].tap()
        app.tabBars.buttons["الفواتير"].tap()
        let searchField = app.searchFields["للبحث: ادخل رقم او تاريخ الفاتورة"]
        searchField.tap()
        searchField.typeText("3")
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["3"]/*[[".cells.staticTexts[\"3\"]",".staticTexts[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["3"]/*[[".cells.staticTexts[\"3\"]",".staticTexts[\"3\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.exists)
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
