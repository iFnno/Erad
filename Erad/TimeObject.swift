//
//  TimeObject.swift
//  إيراد
//
//  Created by Afnan S on 3/31/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import Foundation
struct TimeObject {
    
    var start : String!
    var end : String!
    var total : String!
    var day : String!
    
    
    init (start : String, end : String, total : String, day : String) {
        self.start = start
        self.end = end
        self.total = total
        self.day = day
}
    init  (total : String, day : String) {
        self.total = total
        self.day = day
    }
}
