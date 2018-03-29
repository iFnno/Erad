//
//  ReportsViewController.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {
    
    @IBAction func salesButton(_ sender: Any) {
        self.performSegue(withIdentifier: "salesSeg", sender: self)
    }
    
    
    @IBAction func workingHoursButton(_ sender: Any) {
        self.performSegue(withIdentifier: "hoursSeg", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "salesSeg" {
            _ = segue.destination as! SalesReportViewController
        }
        if segue.identifier == "hoursSeg" {
            _ = segue.destination as! WorkingHoursReportViewController
        }
    }

}
