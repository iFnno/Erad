//
//  salesObject.swift
//  إيراد
//
//  Created by Afnan S on 4/1/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
struct salesObject {
    
    var totalPrice : Double!
    var totalQuantity : Int!
    var day : String!
    
    
    init (totalPrice : Double, totalQuantity : Int, day : String) {
        self.totalPrice = totalPrice
        self.totalQuantity = totalQuantity
        self.day = day
    }
}
