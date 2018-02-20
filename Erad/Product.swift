//
//  Product.swift
//  إيراد
//
//  Created by Afnan S on 2/13/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
import UIKit
struct Product {
    
    var pname : String!
    var imgUrl : String!
    var inventory : Int!
    var price : Double!
    var image : UIImage
    var description : String!
    var pID : String!
    
    init (pname:String, img : UIImage, inventory : Int, price : Double, desc : String, pID : String) {
        self.pname = pname
        self.image = img
        self.inventory = inventory
        self.price = price
        self.description = desc
        self.pID = pID
    }

}
