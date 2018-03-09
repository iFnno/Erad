//
//  ReceiptDetailsTableViewCell.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/22/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class ReceiptDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuan: UILabel!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

