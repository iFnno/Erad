//
//  ShoppingCardItems.swift
//  إيراد
//
//  Created by Afnan S on 2/17/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
struct ShoppingCardItem {
    
    var pname : String!
    var quantity : Int!
    var price : Double!
    var pID : String!
    var category : String!
    
    init (pname:String, quantity : Int, price : Double, pID : String, category : String) {
        self.pname = pname
        self.quantity = quantity
        self.price = price
        self.pID = pID
        self.category = category
    }
    
}