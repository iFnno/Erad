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
        activityIndicator.startAnimating()
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
      /*   ref = Database.database().reference().child("Categories")
        ref.observe(DataEventType.childAdded, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv)
                    print(oneProduct)
                    self.ProductsList.append(oneProduct)
                }
                self.ListTable.reloadData()
            }
        }) */
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.ProductsList.removeAll()
        let ref = Database.database().reference().child("Categories")
        ref.observe(DataEventType.childAdded, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv)
                    self.ProductsList.append(oneProduct)
                }
                self.ListTable.reloadData()
            }
        })
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
        cell.inventory.text = String(self.ProductsList[indexPath.row].inventory)
       
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
