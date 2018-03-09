//
//  ReceiptTableViewCell.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/19/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {
    
    @IBOutlet weak var receiptDate: UILabel!
    @IBOutlet weak var receiptID: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
