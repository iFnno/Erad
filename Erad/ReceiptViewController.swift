//
//  ReceiptViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/17/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // var oneRproduct = [ShoppingCardItem]()
    var ref: DatabaseReference!
    var ref1: DatabaseReference!
    var ref2 : DatabaseReference!
    var receiptList = [Receipt]()
    var filterRreceipt = [Receipt]()
    var searchActive : Bool = false
    var Rproducts = [ShoppingCardItem]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var receiptsTable: UITableView!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "الفواتير"
        
        ref = Database.database().reference().child(companyName).child("receipts")
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.receiptList.removeAll()
                //iterating through all the values
                for receipt in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let eventsObject = receipt.value as? [String: AnyObject]
                    let rid  = eventsObject?["id"]
                    let rdate = eventsObject?["date"]
                    let rtotalp = eventsObject?["totalPrice"]
                    let rtime = eventsObject?["time"]
                    let employeeID = eventsObject?["employeeID"] as! String
                    let ReceivedAmount = eventsObject?["ReceivedAmount"]
                    let RemainingAmount = eventsObject?["RemainingAmount"]
                    
                    let recKey = receipt.key.description as NSString
                    self.count = self.count+1
                    print(recKey)
                    var receipt = Receipt(id: rid as! Int , date : rdate as! String , time : rtime as! String ,totalPrice :rtotalp as! Double, employeeID : employeeID as String ,key: recKey as! String ,ReceivedAmount: ReceivedAmount  as! Int , RemainingAmount: RemainingAmount as! Int)
                    //appending to list
                    //receipt.products = self.Rproducts
                    self.receiptList.append(receipt)
                    
                }
                self.receiptList.reverse()
                self.receiptsTable.reloadData()

            }})
        //reloading the tableview
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            if self.receiptList.count == 0 {
                self.createAlert(title: "لا يوجد محتوى", message: "لا يوجد معلومات لهذه الصفحة" )
            }
        }
        receiptsTable.delegate = self
        receiptsTable.dataSource = self
        searchBar.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //table
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filterRreceipt.count
        }
        else {
            return receiptList.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = receiptsTable.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as! ReceiptTableViewCell
        
        let onereceipt : Receipt
        
        if(searchActive){
            onereceipt = filterRreceipt[indexPath.row]
            cell.receiptID.text = String(onereceipt.id)
            cell.receiptDate.text = onereceipt.date
            
        }
        else {
            onereceipt = receiptList[indexPath.row]
            cell.receiptID.text = String(onereceipt.id)
            cell.receiptDate.text = onereceipt.date
        }
        
        return cell}
    //search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterRreceipt = receiptList.filter({ (text) -> Bool in
            
            let temp1: NSString = String(text.id) as NSString
            let temp2: NSString = text.date as NSString
            
            return (temp1.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                || (temp2.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        if((filterRreceipt.count == 0)&&(searchText=="")){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.receiptsTable?.reloadData()
        
    }
    //cell selected
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.receiptsTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Rdetails" {
            if let indexPath = self.receiptsTable.indexPathForSelectedRow {
                let controller = segue.destination as! ReceiptDetailsViewController
                let value : Receipt
                
                if(searchActive) {
                    value = filterRreceipt[indexPath.row]
                }
                else {
                    value = receiptList[indexPath.row]
                }
                controller.Rdetsils = value}}}
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "حسناً", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

