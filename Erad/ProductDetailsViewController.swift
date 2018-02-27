//
//  ProductDetailsViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/14/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    var productInfo : Product = Product(pname: "", img: #imageLiteral(resourceName: "Logo.png"), inventory: 0, price: 0, desc: "", pID: "", category: "")
    var quantity : Int = 1
    @IBOutlet weak var selectedQuantity: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productDesc: UILabel!
    
    @IBOutlet weak var productInventory: UILabel!
    
    
    @IBAction func plus(_ sender: Any) {
        if self.productInfo.inventory > self.quantity {
        self.quantity = self.quantity + 1
        self.selectedQuantity.text = String(self.quantity)
        
        } else {
            let mess = "يتواجد فقط عدد " + String(self.quantity) + " حبة من المنتج"
            makeAlert.ShowAlert(title: "المخزون غير كافي", message: mess , in: self)
        }
    }
    
    @IBAction func minus(_ sender: Any) {
        if self.quantity != 0 {
        self.quantity = self.quantity - 1
        self.selectedQuantity.text = String(self.quantity)
    }
    }
    
    
    
    @IBAction func addToCart(_ sender: Any) {
        if self.quantity != 0 {
            let item = ShoppingCardItem(pname: self.productInfo.pname, quantity: self.quantity, price: self.productInfo.price, pID: self.productInfo.pID, category: self.productInfo.category)
       // let controller = self.navigationController?.popViewController(animated: true)
        //controller.shoppingCard.append(item)
        _ = self.navigationController?.popViewController(animated: true)
        let previousViewController = self.navigationController?.viewControllers.last as! ProductsMenuViewController
        previousViewController.shoppingCard.append(item)
        
        }
        else {
            makeAlert.ShowAlert(title: "الكمية غير صحيحة", message: "فضلاً حدد الكمية المناسبة", in: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = self.productInfo.image
        productName.text = self.productInfo.pname
        productPrice.text = String(self.productInfo.price)
        productDesc.text = self.productInfo.description
        productInventory.text = String(self.productInfo.inventory)
        self.selectedQuantity.text = String(self.quantity)

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}