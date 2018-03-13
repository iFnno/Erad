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
    var key : String!
    var ReceivedAmount: Int!
    var RemainingAmount: Int!
    
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
    init (id : Int, date : String, totalPrice : Double, time : String, employeeID : String, key : String) {
        self.id = id
        self.totalPrice = totalPrice
        self.employeeID = employeeID
        self.time = time
        self.date = date
        self.key = key
    }
    init (id :Int, date: String, time : String ,totalPrice: Double, products : [ShoppingCardItem]){
        self.id = id
        self.date = date
        self.totalPrice = totalPrice
        self.products = products }
    
    init (id :Int, date: String, time : String ,totalPrice: Double, key : String){
        self.id = id
        self.date = date
        self.totalPrice = totalPrice
        self.key = key
    }
    init (id :Int, date: String, time : String ,totalPrice: Double, employeeID : String, key : String, ReceivedAmount: Int, RemainingAmount: Int){
        self.id = id
        self.date = date
        self.totalPrice = totalPrice
        self.key = key
        self.employeeID = employeeID
        self.ReceivedAmount = ReceivedAmount
        self.RemainingAmount = RemainingAmount
        
    }
}
