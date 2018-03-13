//
//  RefundTableViewCell.swift
//  إيراد
//
//  Created by Raghad Almojil on 3/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class RefundTableViewCell: UITableViewCell {
    var onMButtonTapped : (() -> Void)? = nil
    @IBAction func minusPressed(_ sender: Any) {
        if let onMButtonTapped = self.onMButtonTapped {
            onMButtonTapped()
        } }
    var onPButtonTapped : (() -> Void)? = nil
    @IBAction func plusPressed(_ sender: Any) {
        if let onPButtonTapped = self.onPButtonTapped {
            onPButtonTapped()}}
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

