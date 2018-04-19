//
//  ReceiptDetailsViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/17/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class ReceiptDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    
    @IBOutlet weak var RproductTable: UITableView!
    var Rdetsils : Receipt! = Receipt(id: 0, date: "", totalPrice: 0, time: "", employeeID: "String", products: [])
    
    var items : [ShoppingCardItem] = []
    @IBOutlet var RtotalPrice: UILabel!
    @IBOutlet var Rdate: UILabel!
    @IBOutlet var rID: UILabel!
    var ref1 : DatabaseReference!
    var reckey : String!
    var amount : Double! = 0.0
    
    @IBAction func refundButton1(_ sender: UIButton) {
        if startedAlready == true {
        self.performSegue(withIdentifier:"refund", sender: self)
        } else {
            let mess = "لطفاً قم ببدء وقت العمل الخاص بك"
            makeAlert.ShowAlert(title: "انت في غير وقت العمل الآن", message: mess , in: self)
        }
        }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = " تفاصيل الفاتورة"
        self.Rdate.text = Rdetsils.date
        self.rID.text = String(Rdetsils.id)
        self.RtotalPrice.text = String(Rdetsils.totalPrice) + " ر.س"
        // Do any additional setup after loading the view.
        let backItem = UIBarButtonItem()
        backItem.title = "رجوع"
        ref1 = Database.database().reference().child(companyName)
        ref1.child("receipts").child(self.Rdetsils.key).child("products").observe(DataEventType.value, with: { (snapshot1) in
            //if the reference have values
            if snapshot1.childrenCount > 0 {
                //clearing the list self.items.removeAll()
                //iterating through all the values
                for receipt in snapshot1.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let eventsObject1 = receipt.value as? [String: AnyObject]
                    let productKey = receipt.key.description as NSString
                    let category = eventsObject1?["category"] as! String
                    let price = eventsObject1?["price"] as! Double
                    let quantity = eventsObject1?["quantity"] as! Int
                    let cost = eventsObject1!["cost"] as! Double
                    self.ref1.child("products").child(category).child(productKey as String).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let productName = value?["name"] as! String
                        let productPrice = value?["price"] as! Double
                        let productCategory = value?["category"] as! String
                        print("here is the other loop")
                        print(productName)
                        print(productPrice)
                        let oneProduct = ShoppingCardItem(pname: productName, quantity: quantity, price: productPrice, pID: productKey as String, category: productCategory, cost: cost)

                        self.amount = self.amount + (Double(quantity) * price )
                        self.items.append(oneProduct)
                        self.RproductTable.reloadData()
                    })
                    
                }
            }
            
        })
        
        RproductTable.delegate = self
        RproductTable.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        self.RtotalPrice.text = String(self.amount) + " ر.س"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RproductTable.dequeueReusableCell(withIdentifier: "productsCell", for: indexPath) as! ReceiptDetailsTableViewCell
        cell.productPrice.text = String(items[indexPath.row].price)
        cell.productQuan.text = String(items[indexPath.row].quantity)
        cell.productName.text = items[indexPath.row].pname
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "refund" {
            let controller = segue.destination as! RefundViewController
            controller.ReceiptDetsils = Rdetsils
            controller.itemsList = items
            controller.RefundedItemsList = items
            controller.amount = self.amount
            
        }
    }
    
}




