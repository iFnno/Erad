//
//  MakeReceiptViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/18/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class MakeReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
var shoppingCard : [ShoppingCardItem] = [] 
    var amount : Double! = 0.0
    @IBOutlet weak var itemsTable: UITableView!
    
    @IBOutlet weak var amountL: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "عربة التسوق"
        self.amountL.text = String(self.amount)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.amountL.text = String(self.amount)
    }
    

    func tableView( _ booksTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCard.count
        
    }
    
    func tableView( _ booksTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = booksTable.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! MakeReceiptTableViewCell
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
        
    }
    
    @IBAction func pauseSaleOperationButton(_ sender: Any) {
        
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
}
