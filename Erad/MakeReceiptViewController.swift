//
//  MakeReceiptViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/18/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class MakeReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
var shoppingCard : [ShoppingCardItem] = [] 
    var amount : Double! = 0.0
    var receiptID : Int = 0
    var ReceivedAmountText : Double! = 0.0
    var RemainingAmount : Double! = 0.0
    var paused = false
    var ref : DatabaseReference!
    @IBOutlet weak var itemsTable: UITableView!
    
    @IBOutlet weak var amountL: UILabel!
    
    
    @IBOutlet weak var ReceifedAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "عربة التسوق"
        self.amountL.text = String(self.amount)
        ReceifedAmount.delegate = self as! UITextFieldDelegate
        self.ReceifedAmount.text = "0.0"
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.amountL.text = String(self.amount)
        //self.ReceivedAmountText = self.ReceifedAmount.text as? Double
    }
    

    func tableView( _ itemsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCard.count
        
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! MakeReceiptTableViewCell
        cell.selectionStyle = .none
        cell.pName.text = self.shoppingCard[indexPath.row].pname
        cell.Quantity.text = String(self.shoppingCard[indexPath.row].quantity)
        cell.pamount.text = String(self.shoppingCard[indexPath.row].price * Double(self.shoppingCard[indexPath.row].quantity)) + " SR"
        self.amount = (self.shoppingCard[indexPath.row].price * Double(self.shoppingCard[indexPath.row].quantity)) + self.amount
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   if let selectionIndexPath = self.itemsTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        //itemsTable.setEditing(true, animated: true)
    }
    
    @IBAction func makeSaleOperationButton(_ sender: Any) {

            self.ref = Database.database().reference()
            let ch = self.ref.child("receipts").childByAutoId()
        for ind in shoppingCard {
            self.ref.child("Categories").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                if num > 0 {
                let newnum = num - ind.quantity
                let newnumString = Int(newnum)
                   self.ref.child("Categories").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
                   // self.ReceivedAmountText = self.ReceifedAmount.text as? Double
                    if let cost = Double(self.ReceifedAmount.text!) {
                        if cost > 0 {
                        print("The user entered a value price of \(cost)")
                        self.ReceivedAmountText = cost
                        self.RemainingAmount = self.ReceivedAmountText - self.amount
                        self.performSegue(withIdentifier: "showReceipt", sender: self)
                        } else {
                            makeAlert.ShowAlert(title: "المبلغ المستلم غير صحيح", message: "عذراً ادخل المبلغ المستلم بشكل صحيح" , in: self)
                        }
                    } else {
                        print("Not a valid number: \(self.ReceifedAmount.text!)")
                    }
                   
                } else {
                    let mess = "يتواجد فقط عدد " + String(ind.quantity) + " حبة من المنتج"
                    makeAlert.ShowAlert(title: "المخزون غير كافي", message: mess , in: self)
                }
                    
                })
        }
      /*  let previousViewController = self.navigationController?.viewControllers.last as! ProductsMenuViewController
        previousViewController.shoppingCard.removeAll()
        previousViewController.currentShoppingCardButton.isHidden = true */
        
    }
    
    @IBAction func pauseSaleOperationButton(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateToAppend = String(formatter.string(from: date))
        let userID = Auth.auth().currentUser?.uid.description
        formatter.dateFormat = "HH:mm"
        let timeToAppend = String(formatter.string(from: date))
        print(timeToAppend)
        
        
        self.ref = Database.database().reference()
        let ch = self.ref.child("pausedReceipts").childByAutoId()
        
        ch.setValue(["date": dateToAppend,"employeeID": userID,"id":self.receiptID ,"time": timeToAppend,"totalPrice":self.amount,"products": ""])
        for ind in shoppingCard {
            ch.child("products").child(ind.pname).setValue(["price": ind.price,"quantity": ind.quantity])
            self.ref.child("Categories").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                if num > 0 {
                    let newnum = num - ind.quantity
                    let newnumString = Int(newnum)
                    self.ref.child("Categories").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
                } else {
                    let mess = "يتواجد فقط عدد " + String(ind.quantity) + " حبة من المنتج"
                    makeAlert.ShowAlert(title: "المخزون غير كافي", message: mess , in: self)
                }
                
            })
        }
        self.empty()
        
    }
    
    @IBAction func cancelSaleOperationButton(_ sender: Any) {
        let alertController = UIAlertController(title: "إلغاء عملية البيع", message: "هل انت متأكد من  إلغائك عملية البيع؟ ", preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING OK BUTTON
        
        let OKAction = UIAlertAction(title: "نعم", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            self.empty()
            
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "تراجع", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
     
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            if itemsTable.numberOfRows(inSection: indexPath.row) == 1 {
            shoppingCard.remove(at: indexPath.row)
                empty()

            } else {
                shoppingCard.remove(at: indexPath.row)
            }
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    func empty() -> Void {
        _ = self.navigationController?.popViewController(animated: true)
        let previousViewController = self.navigationController?.viewControllers.last as! ProductsMenuViewController
        previousViewController.shoppingCard.removeAll()
        previousViewController.currentShoppingCardButton.isHidden = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReceipt" {
            let controller = segue.destination as! ReceiptPageViewController
            controller.shoppingCard = self.shoppingCard
            controller.amount = self.amount
            controller.receiptID = self.receiptID
            controller.ReceivedAmount = self.ReceivedAmountText
            controller.RemainingAmount = self.RemainingAmount
        }
    }
}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    /*  func substring(from: Int) -> String {
     let fromIndex = index(self.startIndex, offsetBy: from)
     return substring(from: fromIndex)
     }
     
     func substring(to: Int) -> String {
     let toIndex = index(from: to)
     return substring(to: toIndex)
     } */
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
