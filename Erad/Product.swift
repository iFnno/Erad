//
//  Product.swift
//  إيراد
//
//  Created by Afnan S on 2/13/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation

struct Product {
    
    var pname : String!
    var imgUrl : String!
    var inventory : Int!
    var price : Double!  //ID
    
    init (pname:String, imgUrl : String, inventory : Int, price : Double) {
        self.pname = pname
        self.imgUrl = imgUrl
        self.inventory = inventory
        self.price = price
      
}
}
