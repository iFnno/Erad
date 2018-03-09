//
//  InventoryViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/23/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
class InventoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var ref : DatabaseReference!
    var ProductsList : [Product] = []
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var ListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        ref = Database.database().reference().child("products")

        
        // Do any additional setup after loading the view.
    }
    

    func tableView( _ booksTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductsList.count
    }
    
    func tableView( _ booksTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.activityIndicator.stopAnimating()
        let cell = booksTable.dequeueReusableCell(withIdentifier: "invCell", for: indexPath) as! InventoryTableViewCell
        cell.selectionStyle = .none
        cell.img.image = self.ProductsList[indexPath.row].image
        cell.name.text = self.ProductsList[indexPath.row].pname
        self.ref.child(self.ProductsList[indexPath.row].category).child(self.ProductsList[indexPath.row].pID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let productInv  = value?["inventory"] as! Int
            cell.inventory.text = String(productInv)
        })
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.ListTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
        //itemsTable.setEditing(true, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}
