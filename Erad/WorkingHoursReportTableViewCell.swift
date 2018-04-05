//
//  WorkingHoursReportTableViewCell.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class WorkingHoursReportTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var stratTime: UILabel!
    
    @IBOutlet weak var endTime: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
