//
//  SalesReportTableViewCell.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class SalesReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    

    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
