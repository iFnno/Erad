//
//  RefundViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 3/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class RefundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var ReceiptDetsils : Receipt!
    var NewReceipt : Receipt!
    var itemsList : [ShoppingCardItem] = [] // the actual list ps: this will not change
    var RefundedItemsList : [ShoppingCardItem] = []
    
    let ref = Database.database().reference().child(companyName)
    var ref3 : DatabaseReference!
    var reckey : String!
    var amount : Double! = 0.0
    var counter = 0
    var currentEmployee : String! = ""
    var userN : String! = ""
    var refundPrice : Double! = 0.0
    
    
    @IBOutlet weak var refundedAmount: UILabel!//retunrned to customer
    @IBOutlet weak var rtotalPrice: UILabel!
    @IBOutlet weak var rdate: UILabel!
    @IBOutlet weak var rid: UILabel!
    @IBOutlet weak var productTabel: UITableView!
    
    @IBAction func confirmRefund(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todaysDate = String(formatter.string(from: date))
        formatter.dateFormat = "HH:mm"
        let currentTime = String(formatter.string(from: date))
        let alertController = UIAlertController(title: "استرجاع منتج", message: "هل تود إتمام عملية الإسترجاع", preferredStyle: UIAlertControllerStyle.alert)
        //Create ok button
        let OKAction = UIAlertAction(title: "نعم", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            // delete old receipt
         /*   self.ref.child("receipts").observe(DataEventType.value , with: {(snapshot)
                in
                if snapshot.exists(){
                    for receipt in snapshot.children.allObjects as! [DataSnapshot] {
                        let eventsObject = receipt.value as? [String: AnyObject]
                        let key = self.ReceiptDetsils.key
                        let recKey = receipt.key.description as NSString
                        if (key as! String == recKey as String ) { self.ref.child("receipts").child(recKey as String).removeValue(completionBlock: { (error, refer) in
                            if error != nil {
                                print(error)
                            } else {
                                print(refer)
                                print("Child Removed Correctly")
                            }})}}}}) */
            
            // new receipt
            self.NewReceipt = Receipt(id: self.ReceiptDetsils.id , date: todaysDate, time: currentTime, totalPrice: self.amount, employeeID: self.ReceiptDetsils.employeeID, ReceivedAmount: self.ReceiptDetsils.ReceivedAmount, RemainingAmount: self.ReceiptDetsils.RemainingAmount, refundEmployeeID: self.currentEmployee)

            
            //perform segue
            self.performSegue(withIdentifier: "goReceipt", sender: self)
            
            
        }//ok action
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "تراجع", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped"); }
        alertController.addAction(cancelAction)
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)}
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentEmployee = Auth.auth().currentUser?.uid.description
        self.title = "استرجاع منتج"
        self.rid.text = String (ReceiptDetsils.id)
        self.rdate.text = ReceiptDetsils.date
        self.amount = 0
        self.rtotalPrice.text = String(self.amount) + " ر.س"
        for ind in itemsList {
            self.refundPrice = Double(ind.quantity) * ind.price
        }
        let returned = ReceiptDetsils.totalPrice - self.amount
       self.refundedAmount.text = String(self.refundPrice) + " ر.س"
        print("number of items list", itemsList.count)
        productTabel.delegate = self
        productTabel.dataSource = self
        productTabel.reloadData()
        let userID1 = (Auth.auth().currentUser?.uid.description)!
        ref3 = Database.database().reference().child(companyName)
        ref3.child("employees").child(userID1).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let Fname  = value["firstName"] as! String
            let Lname = value["lastName"] as! String
            let x = Fname + " " + Lname
            self.userN = x
            Swift.print(x, separator: "us ", terminator: "usern")
        })
        
       /*deafult return all
        for item in self.RefundedItemsList{
            let item.quantity = 0
        }*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    override func viewDidAppear(_ animated: Bool) {
        self.rtotalPrice.text = String(self.amount) + " ر.س"
        //let returned = ReceiptDetsils.totalPrice - self.amount
       // self.refundedAmount.text = String(returned) + " ر.س"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTabel.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! RefundTableViewCell
        let actualQuantity = RefundedItemsList[indexPath.row].quantity
        cell.price.text = String(itemsList[indexPath.row].price)
        cell.quantity.text = String(RefundedItemsList[indexPath.row].quantity)
        cell.name.text = itemsList[indexPath.row].pname
        cell.onMButtonTapped = {
            let num = self.RefundedItemsList[indexPath.row].quantity
            if(num != 0) // 0 beacuse the user maight not retirn one of the items in the list
            {
                let num = num!-1
                print(num)
                cell.quantity.text = String(num)
                self.RefundedItemsList[indexPath.row].quantity = num
                self.refundedAmount.text = String(self.ReceiptDetsils.totalPrice - Double(num) * self.itemsList[indexPath.row].price ) + " ر.س"
                self.amount = self.amount + self.RefundedItemsList[indexPath.row].price
                self.rtotalPrice.text = String(self.amount) + " ر.س"
                            }}
        cell.onPButtonTapped = {
            let num = self.RefundedItemsList[indexPath.row].quantity
            if(num! < actualQuantity!){
                let num = num!+1
                print(num)
                cell.quantity.text = String(num)
                self.RefundedItemsList[indexPath.row].quantity = num
                self.amount = self.amount - self.RefundedItemsList[indexPath.row].price
                self.rtotalPrice.text = String(self.amount) + " ر.س"
                 self.refundedAmount.text = String(self.ReceiptDetsils.totalPrice - Double(num) * self.itemsList[indexPath.row].price) + " ر.س"
            }}
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goReceipt" {
            let controller = segue.destination as! ReceiptPageViewController
          controller.refundReceipt = self.NewReceipt
            controller.fromRefund = true
            controller.userName = self.userN
            controller.RemainingAmount = Double(self.refundedAmount.text!)
            controller.RefundList = self.RefundedItemsList
            controller.DeleteReceitKey = self.ReceiptDetsils.key
            controller.fromReceiptsPage = true
            
        }
    }

    
    
}

