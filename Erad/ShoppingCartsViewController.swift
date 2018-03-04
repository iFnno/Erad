//
//  ShoppingCartsViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
class ShoppingCartsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var pausedTable: UITableView!
    var pausedList : [Receipt] = []
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "عربات التسوق"
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let ref = Database.database().reference().child("pausedReceipts")
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.pausedList.removeAll()
            
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let id  = eventsObject?["id"] as! Int
                    let date  = eventsObject?["date"] as! String
                    let employeeID  = eventsObject?["employeeID"] as! String
                    let totalPrice  = eventsObject?["totalPrice"] as! Double
                    let time  = eventsObject?["time"] as! String
                    let onereceipt = Receipt(id: id, date: date, totalPrice: totalPrice, time: time, employeeID: employeeID)
                    self.pausedList.append(onereceipt)
                }
                self.pausedTable.reloadData()
            }
        })

    }
    func tableView( _ booksTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pausedList.count
        
    }
    
    func tableView( _ booksTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.activityIndicator.stopAnimating()
        let cell = booksTable.dequeueReusableCell(withIdentifier: "pausedCell", for: indexPath) as! PausedShoppingCartTableViewCell
        cell.selectionStyle = .none
        cell.id.text = String(self.pausedList[indexPath.row].id)
        cell.date.text = self.pausedList[indexPath.row].date
        cell.time.text = self.pausedList[indexPath.row].time
        cell.employeeID.text = self.pausedList[indexPath.row].employeeID
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.pausedTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        //itemsTable.setEditing(true, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSeg" {
            if let indexPath = self.pausedTable.indexPathForSelectedRow {
                let controller = segue.destination as! MakeReceiptViewController
                controller.amount = self.pausedList[indexPath.row].totalPrice
                controller.paused = true
                controller.receiptID = self.pausedList[indexPath.row].id!
                controller.RemainingAmount = 0
                controller.shoppingCard = self.pausedList[indexPath.row].products
            }
        }
    }

}
