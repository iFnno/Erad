//
//  MakeReceiptTableViewCell.swift
//  إيراد
//
//  Created by Afnan S on 2/18/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class MakeReceiptTableViewCell: UITableViewCell {
    
    var onMButtonTapped : (() -> Void)? = nil
    var onPButtonTapped : (() -> Void)? = nil

    @IBOutlet weak var pName: UILabel!
    
    @IBOutlet weak var Quantity: UILabel!
    
    @IBOutlet weak var pamount: UILabel!
    
    
    @IBAction func plusPressed(_ sender: Any) {
        if let onPButtonTapped = self.onPButtonTapped {
            onPButtonTapped()}
    }
    
    @IBAction func minusPressed(_ sender: Any) {
        if let onMButtonTapped = self.onMButtonTapped {
            onMButtonTapped()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
