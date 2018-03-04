//
//  Receipt.swift
//  إيراد
//
//  Created by Afnan S on 3/3/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
struct Receipt {
    
    var id : Int!
    var date : String!
    var totalPrice : Double!
    var time : String!
    var employeeID : String!
    var products : [ShoppingCardItem]!
    
    init (id : Int, date : String, totalPrice : Double, time : String, employeeID : String, products : [ShoppingCardItem]) {
        self.id = id
        self.totalPrice = totalPrice
        self.employeeID = employeeID
        self.time = time
        self.date = date
        self.products = products
}
    
    init (id : Int, date : String, totalPrice : Double, time : String, employeeID : String) {
        self.id = id
        self.totalPrice = totalPrice
        self.employeeID = employeeID
        self.time = time
        self.date = date
    }
}
