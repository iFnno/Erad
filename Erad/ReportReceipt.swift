//
//  ReportReceipt.swift
//  إيراد
//
//  Created by Afnan S on 4/2/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
struct ReportReceipt {
    

    var date : String!
    var totalPrice : Double!
    var employeeID : String!
    var key : String!
    init ( date: String , totalPrice: Double, employeeID : String, key : String) {
        self.date = date
        self.totalPrice = totalPrice
        self.employeeID = employeeID
        self.key = key
        
}
}

