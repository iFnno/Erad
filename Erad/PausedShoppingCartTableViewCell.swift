//
//  PausedShoppingCartTableViewCell.swift
//  إيراد
//
//  Created by Afnan S on 3/3/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class PausedShoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var employeeID: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
