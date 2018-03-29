//
//  SalesReportViewController.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class SalesReportViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var salesTable: UITableView!
    var salesList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView( _ itemsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
       return salesList.count
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "salesCell", for: indexPath) as! SalesReportTableViewCell
            
         /*   cell.selectionStyle = .none
            print("naaamee")
            print(self.pausedShoppingCard[indexPath.row].pname)
            cell.pName.text = self.pausedShoppingCard[indexPath.row].pname
            cell.Quantity.text = String(self.pausedShoppingCard[indexPath.row].quantity)
            cell.pamount.text = String(self.pausedShoppingCard[indexPath.row].price * Double(self.pausedShoppingCard[indexPath.row].quantity)) + " SR" */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.salesTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
    }

}
