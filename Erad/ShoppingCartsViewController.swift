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

    @IBOutlet weak var pausedTable: UITableView!
    var pausedList : [Receipt] = []
    var productsList : [ShoppingCardItem] = []
    var ref : DatabaseReference!
    var ref1 : DatabaseReference!
    var ref3 : DatabaseReference!
    var userN : String! = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "عربات التسوق المعلقة"
        let image = UIImage(named: "Menu1.png")
        let button = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.plain, target: self.splitViewController!.displayModeButtonItem.target, action: self.splitViewController!.displayModeButtonItem.action)
        button.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = button
        self.pausedTable.reloadData()
        
        let ref = Database.database().reference().child(companyName)
        ref.child("pausedReceipts").observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.pausedList.removeAll()
            
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let id  = eventsObject?["id"] as! Int
                    let date  = eventsObject?["date"] as! String
                    let employeeID  = eventsObject?["employeeID"] as! String
                    let totalPrice  = eventsObject?["totalPrice"] as! Double
                    let time  = eventsObject?["time"] as! String
                        let key = c.key.description as NSString
                    let onereceipt = Receipt(id: id, date: date, totalPrice: totalPrice, time: time, employeeID: employeeID, key : key as String)
                    self.pausedList.append(onereceipt)
                    print(self.pausedList)
                    print("rima")
                }
                self.pausedTable.reloadData()
            }
        })
        
    }
    func tableView( _ booksTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pausedList.count
        
    }
    
    func tableView( _ booksTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = booksTable.dequeueReusableCell(withIdentifier: "pausedCell", for: indexPath) as! PausedShoppingCartTableViewCell
        cell.selectionStyle = .none
        ref3 = Database.database().reference().child(companyName)
        ref3.child("employees").child(self.pausedList[indexPath.row].employeeID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let Fname  = value["firstName"] as! String
            let Lname = value["lastName"] as! String
            let x = Fname + Lname
            self.userN = x
            Swift.print(x, separator: "us ", terminator: "usern")
        })
        cell.id.text = String(self.pausedList[indexPath.row].id)
        cell.date.text = self.pausedList[indexPath.row].date
        cell.time.text = self.pausedList[indexPath.row].time
        cell.employeeID.text = self.userN
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
               // controller.receiptID = self.pausedList[indexPath.row].id!
                controller.RemainingAmount = 0
                controller.passedReceipt = self.pausedList[indexPath.row]
            }
        }
    }

}
