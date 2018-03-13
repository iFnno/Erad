//
//  MakeReceiptViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/18/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
var receiptID : Int = 0
class MakeReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate , MFMailComposeViewControllerDelegate {
    var shoppingCard : [ShoppingCardItem] = []
    var pausedShoppingCard : [ShoppingCardItem] = []
    var inipausedShoppingCard : [ShoppingCardItem] = []
    var amount : Double! = 0.0
    var userN : String! = ""
    
    var ReceivedAmountText : Double! = 0.0
    var RemainingAmount : Double! = 0.0
    var paused = false
    var pausedProductsKeys : [String] = []
    var ref : DatabaseReference!
    var ref1 : DatabaseReference!
    var ref2 : DatabaseReference!
    var ref3 : DatabaseReference!
    var passedReceipt : Receipt! = Receipt(id: 0, date: "", totalPrice: 0, time: "", employeeID: "", key: "")
    @IBOutlet weak var itemsTable: UITableView!
    
    @IBOutlet weak var amountL: UILabel!
    
    
    @IBOutlet weak var ReceifedAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "عربة التسوق"
        self.amountL.text = String(self.amount)
        ReceifedAmount.delegate = self as UITextFieldDelegate
        if self.paused == true {
            
          ref1 = Database.database().reference()
        ref1.child("pausedReceipts").child(self.passedReceipt.key).child("products").observe(DataEventType.value, with: { (snapshot1) in
            if snapshot1.childrenCount > 0 {
                self.inipausedShoppingCard.removeAll()
                for s in snapshot1.children.allObjects as! [DataSnapshot] {
                    let eventsObject1 = s.value as? [String: AnyObject]
                    let key = s.key.description as NSString
                    
                    let price = eventsObject1!["price"] as! Double
                    let quantity = eventsObject1!["quantity"] as! Int
                    let category = eventsObject1!["category"] as! String
                    self.ref2 = Database.database().reference().child("products")
                        self.ref2.child(category).child(key as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                            let value = snapshot.value as? NSDictionary
                            let productName  = value?["name"] as! String
                            let productPrice  = value?["price"] as! Double
                            let productCategory = value?["category"] as! String
                            
                            let oneProduct = ShoppingCardItem(pname: productName, quantity: quantity, price: productPrice, pID: key as String, category: productCategory)
                            self.pausedShoppingCard.append(oneProduct)
                            self.itemsTable.reloadData()
                    })
                }
            }
        })
        
            }

        
       
        
        let userID1 = (Auth.auth().currentUser?.uid.description)!
        ref3 = Database.database().reference()
        ref3.child("employees").child(userID1).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let Fname  = value["firstName"] as! String
            let Lname = value["lastName"] as! String
            let x = Fname + Lname
            self.userN = x
            Swift.print(x, separator: "us ", terminator: "usern")
        })
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.amountL.text = String(self.amount)
        self.ReceifedAmount.text = String(self.amount)
        //self.ReceivedAmountText = self.ReceifedAmount.text as? Double
    }
    

    func tableView( _ itemsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.paused == true {
            return pausedShoppingCard.count
        } else {
        return shoppingCard.count
        }
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! MakeReceiptTableViewCell
        if self.paused == true {

            cell.selectionStyle = .none
            print("naaamee")
            print(self.pausedShoppingCard[indexPath.row].pname)
            cell.pName.text = self.pausedShoppingCard[indexPath.row].pname
            cell.Quantity.text = String(self.pausedShoppingCard[indexPath.row].quantity)
            cell.pamount.text = String(self.pausedShoppingCard[indexPath.row].price * Double(self.pausedShoppingCard[indexPath.row].quantity)) + " SR"
            
        } else {
        cell.selectionStyle = .none
        cell.pName.text = self.shoppingCard[indexPath.row].pname
        cell.Quantity.text = String(self.shoppingCard[indexPath.row].quantity)
        cell.pamount.text = String(self.shoppingCard[indexPath.row].price * Double(self.shoppingCard[indexPath.row].quantity)) + " SR"
        self.amount = (self.shoppingCard[indexPath.row].price * Double(self.shoppingCard[indexPath.row].quantity)) + self.amount
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   if let selectionIndexPath = self.itemsTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        //itemsTable.setEditing(true, animated: true)
    }
    
    @IBAction func makeSaleOperationButton(_ sender: Any) {
        if self.paused == true {
            self.ref = Database.database().reference()
            let ch = self.ref.child("receipts").childByAutoId()
            for ind in pausedShoppingCard {
                self.ref.child("products").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                    let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                    if num > 0 {
                        let newnum = num - ind.quantity
                        let newnumString = Int(newnum)
                        self.ref.child("products").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
                        // self.ReceivedAmountText = self.ReceifedAmount.text as? Double
                        if let cost = Double(self.ReceifedAmount.text!) {
                            if cost > 0 {
                                print("The user entered a value price of \(cost)")
                                self.ReceivedAmountText = cost
                                self.RemainingAmount = self.ReceivedAmountText - self.amount
                                self.performSegue(withIdentifier: "showReceipt", sender: self)
                            self.ref.child("pausedReceipts").child(self.passedReceipt.key).removeValue(completionBlock: { (error, refer) in
                                    if error != nil {
                                        print(error)
                                    } else {
                                        print(refer)
                                        print("Child Removed Correctly")
                                    }
                                })

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
        } else {
            self.ref = Database.database().reference()
            let ch = self.ref.child("receipts").childByAutoId()
        for ind in shoppingCard {
            self.ref.child("products").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                if num > 0 {
                   
                let newnum = num - ind.quantity
                let newnumString = Int(newnum)
                   self.ref.child("products").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
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
                    if num == 5 {
                        let composeVC = MFMailComposeViewController()
                        composeVC.mailComposeDelegate = self
                        
                        // Configure the fields of the interface.
                        let email = "asa-cute@hotmail.com"
                        composeVC.setToRecipients([email])
                        let ss = "مخزون المنتج" + ind.pname + "منخفض"
                        composeVC.setSubject(ss)
                        let mess = "<html><body> مرحباً <br> مخزون المنتج " + ind.pname + "من تصنيف" + ind.category + " اقل من 5 <br> شكراً </body>,/html>"
                        composeVC.setMessageBody( mess, isHTML: true)
                        
                        // Present the view controller modally.
                        self.present(composeVC, animated: true, completion: nil)
                        
                        
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
    }
    @IBAction func pauseSaleOperationButton(_ sender: Any) {
        if self.paused == true {
             makeAlert.ShowAlert(title: "العربة معلقة", message: "عذراً أتمم العملية او قم بحذفها" , in: self)
        } else {
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
        receiptID = incrementID()
        ch.setValue(["date": dateToAppend,"employeeID": userID,"id":receiptID ,"time": timeToAppend,"totalPrice":self.amount,"products": ""])
        
        for ind in shoppingCard {
            ch.child("products").child(ind.pID).setValue(["price": ind.price,"quantity": ind.quantity,"category": ind.category])
            self.ref.child("products").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                if num > 0 {
                    let newnum = num - ind.quantity
                    let newnumString = Int(newnum)
                    self.ref.child("products").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
                } else {
                    let mess = "يتواجد فقط عدد " + String(ind.quantity) + " حبة من المنتج"
                    makeAlert.ShowAlert(title: "المخزون غير كافي", message: mess , in: self)
                }
                
            })
        }
        self.empty()
        }
    }
    
    @IBAction func cancelSaleOperationButton(_ sender: Any) {
        if self.paused == true {
            let alertController = UIAlertController(title: "حذف عربة التسوق الحالية", message: "هل انت متأكد من  حذفك عربة التسوق؟ ", preferredStyle: UIAlertControllerStyle.alert)
            
            //CREATING OK BUTTON
            
            let OKAction = UIAlertAction(title: "نعم", style: .default) { (action:UIAlertAction!) in
                
                // Code in this block will trigger when OK button tapped.
                self.ref = Database.database().reference()
                self.ref.child("pausedReceipts").child(self.passedReceipt.key).removeValue(completionBlock: { (error, refer) in
                    if error != nil {
                        print(error)
                    } else {
                        print(refer)
                        print("Child Removed Correctly")
                    }
                })
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
            
        } else {
        let alertController = UIAlertController(title: "حذف عربة التسوق الحالية", message: "هل انت متأكد من  حذفك عربة التسوق الحالية؟ ", preferredStyle: UIAlertControllerStyle.alert)
        
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
     
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            if itemsTable.numberOfRows(inSection: indexPath.row) == 1 {
                if self.paused == true {
                    pausedShoppingCard.remove(at: indexPath.row)
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    shoppingCard.remove(at: indexPath.row)
                    empty()
                }
            

            } else {
                if self.paused == true {
                    let x = (pausedShoppingCard[indexPath.row].price * Double(pausedShoppingCard[indexPath.row].quantity))
                    self.amount = self.amount - x
                    self.viewDidAppear(true)
                    pausedShoppingCard.remove(at: indexPath.row)
                } else {
                    let x = (shoppingCard[indexPath.row].price * Double(shoppingCard[indexPath.row].quantity))
                    self.amount = self.amount - x
                    self.viewDidAppear(true)
                    shoppingCard.remove(at: indexPath.row)
                 
            }
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
            if self.paused == true {
                print("here is list")
                print(self.pausedShoppingCard)
                controller.shoppingCard = self.pausedShoppingCard
                controller.paused = true
                controller.userName = self.userN
            } else {
            controller.shoppingCard = self.shoppingCard
            controller.userName = self.userN
            }
           // controller.amount = self.amount
            receiptID = incrementID()
            controller.receiptID = receiptID
            controller.ReceivedAmount = self.ReceivedAmountText
            controller.RemainingAmount = self.RemainingAmount
            controller.amount = self.amount
            controller.userName = self.userN
        }
    }
    func incrementID() -> Int {
        receiptID = receiptID + 1
        return receiptID
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            break
        case .failed:
            break
            
        }
        
        controller.dismiss(animated: true, completion: nil)
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

