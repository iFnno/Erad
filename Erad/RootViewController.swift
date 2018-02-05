//
//  RootViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var menuTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as!
        MenuTableViewCell
        cell.menuitemTitle.text = "عنوان"
        //returning cell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      /*  if let selectionIndexPath = self.BooksTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        } */
        if indexPath.row == 0 {
            self.openProductMenu()
        }
        if indexPath.row == 1 {
            self.openShoppingCart()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func openProductMenu() {
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController : ProductsMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsMenuViewController") as! ProductsMenuViewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
        
    }
    func openShoppingCart() {
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController : ShoppingCartsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShoppingCartsViewController") as! ShoppingCartsViewController
        
         let navigationController = UINavigationController(rootViewController: viewController)
         
         self.splitViewController?.showDetailViewController(navigationController, sender: self)
        
    }

}
