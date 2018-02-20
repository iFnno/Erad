//
//  ProductsMenuViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
var num : Int = 3
class ProductsMenuViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource {
    var ref: DatabaseReference!
    @IBOutlet weak var ProductsCollectionView: UICollectionView! /* {
        didSet {
            ProductsCollectionView.delegate = self
            ProductsCollectionView.dataSource = self
        }
    } */
    var shoppingCard : [ShoppingCardItem] = []
     var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var currentShoppingCardButton: UIButton!
    
    @IBAction func currentShoppingCardButton(_ sender: Any) {
            self.performSegue(withIdentifier: "shoppingCard", sender: self)
    }
    
    
    
  //  var selectedProduct : Product = Product(pname: "", img: #imageLiteral(resourceName: "Logo.png"), inventory: 0, price: 0, desc: "")
    @IBOutlet weak var scrollview: UIScrollView!
    var category : [Product] = []
    var catNames : [String] = []
    var catNumbers : [Int] = []
    var allCat : [Product] = []
    var cat1 : [Product] = []
    var cat2 : [Product] = []
    var cat3 : [Product] = []
    var cat4 : [Product] = []
    var cat5 : [Product] = []
    var cat6 : [Product] = []
    var cat7 : [Product] = []
    var cat8 : [Product] = []
    var cat9 : [Product] = []
    var cat10 : [Product] = []
    var desiredWidthChange : Double = 1500.0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        switch (selectedSegment.selectedSegmentIndex)
        {
        case 0 :
            returnValue = allCat.count
            print(allCat.count)
        case 1 :
            returnValue = catNumbers[0]
        case 2 :
            returnValue = catNumbers[1]
        case 3 :
            returnValue = catNumbers[2]
        case 4 :
            returnValue = catNumbers[3]
        case 5 :
            returnValue = catNumbers[4]
        case 6 :
            returnValue = catNumbers[5]
        case 7 :
            returnValue = catNumbers[6]
        case 8 :
            returnValue = catNumbers[7]
        case 9 :
            returnValue = catNumbers[8]
        case 10 :
            returnValue = catNumbers[9]
            
        default:
            returnValue = 0
        }
        ProductsCollectionView.reloadData()
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        switch (selectedSegment.selectedSegmentIndex)
        {
        case 0 :
                fillAllItems()
                cell.ProductName.text = self.allCat[indexPath.row].pname
                    cell.imgView.image = self.allCat[indexPath.row].image
            print("All cat are")
            print(allCat)
        case 1 :
            if cat1.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                    self.cat1.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat1[indexPath.row].pname
                    cell.imgView.image = self.cat1[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat1[indexPath.row].pname
               cell.imgView.image = self.cat1[indexPath.row].image
            }

        case 2 :
            if cat2.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                    self.cat2.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat2[indexPath.row].pname
                    cell.imgView.image = self.cat2[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat2[indexPath.row].pname
               cell.imgView.image = self.cat2[indexPath.row].image
            }
        case 3 :
            if cat3.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat3.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat3[indexPath.row].pname
                    cell.imgView.image = self.cat3[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat3[indexPath.row].pname
                cell.imgView.image = self.cat3[indexPath.row].image
            }
        case 4 :
            if cat4.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat4.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat4[indexPath.row].pname
                    cell.imgView.image = self.cat4[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat4[indexPath.row].pname
                cell.imgView.image = self.cat4[indexPath.row].image
            }
        case 5 :
            if cat5.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat5.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat5[indexPath.row].pname
                    cell.imgView.image = self.cat5[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat5[indexPath.row].pname
                cell.imgView.image = self.cat5[indexPath.row].image
            }
        case 6 :
            if cat6.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat6.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat6[indexPath.row].pname
                    cell.imgView.image = self.cat6[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat6[indexPath.row].pname
                cell.imgView.image = self.cat6[indexPath.row].image
            }
        case 7 :
            if cat7.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat7.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat7[indexPath.row].pname
                    cell.imgView.image = self.cat7[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat7[indexPath.row].pname
                cell.imgView.image = self.cat7[indexPath.row].image
            }
        case 8 :
            if cat8.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat8.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat8[indexPath.row].pname
                    cell.imgView.image = self.cat8[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat8[indexPath.row].pname
                cell.imgView.image = self.cat8[indexPath.row].image
            }
        case 9 :
            if cat9.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat9.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat9[indexPath.row].pname
                    cell.imgView.image = self.cat9[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat9[indexPath.row].pname
                cell.imgView.image = self.cat9[indexPath.row].image
            }
            
        case 10 :
            if cat10.count == 0 {
                self.category.removeAll()
                fillItems()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.cat10.append(contentsOf: self.category)
                    cell.ProductName.text = self.cat10[indexPath.row].pname
                    cell.imgView.image = self.cat10[indexPath.row].image
                }
            } else {
                cell.ProductName.text = cat10[indexPath.row].pname
                cell.imgView.image = self.cat10[indexPath.row].image
            }
            
        default:
            ()
            
         
        }
        activityIndicator.stopAnimating()
        return cell
    }
    
    var i : Int = 1
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    @IBAction func selectedSegment(_ sender: Any) {
        self.ProductsCollectionView.reloadData()
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func viewDidAppear(_ animated: Bool) {
        
        if shoppingCard.count != 0 {
            self.currentShoppingCardButton.isHidden = false
 }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "قائمة المنتجات"
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.currentShoppingCardButton.isHidden = true
        selectedSegment.removeAllSegments()
        selectedSegment.insertSegment(withTitle: "الكل" , at: i, animated: true)
        ref = Database.database().reference().child("Categories")
        ref.observe(DataEventType.value, with: { (snapshot) in
         if snapshot.childrenCount > 0 {
        for cat in snapshot.children.allObjects as! [DataSnapshot] {
            let caname = (cat.key.description as NSString) as String
            self.catNumbers.append(Int(cat.childrenCount))
            self.catNames.append(caname)
            self.addCat(name: caname)
    }
        }
            })

        selectedSegment.selectedSegmentIndex = 0
        selectedSegment.removeBorders()
        if self.catNames.count < 6 {
         self.desiredWidthChange = 1500.0
        }
        if self.catNames.count < 3 {
            self.desiredWidthChange = 786.0
        } else {
            self.desiredWidthChange = 2500.0
        }
        self.widthConstraint.constant = CGFloat(self.desiredWidthChange)
        
        selectedSegment.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.selectedSegment.layoutIfNeeded()  // Captures all of the frame changes.
        })
        let font =  UIFont.systemFont(ofSize: 20.0)
        selectedSegment.setTitleTextAttributes([NSAttributedStringKey.font: font as Any , NSAttributedStringKey.foregroundColor: UIColor.lightGray],
                                               for: .normal)
        let font2 = UIFont.boldSystemFont(ofSize: 24.0)
       // let c = UIColor(red: 0.6, green: 0.8314, blue: 0.9569, alpha: 1.0)
        selectedSegment.setTitleTextAttributes([NSAttributedStringKey.font: font2 as Any , NSAttributedStringKey.foregroundColor: UIColor.white],
                                               for: .selected)
         selectedSegment.selectedSegmentIndex = 0
        let ref2 = Database.database().reference().child("Categories").childByAutoId()
        ref2.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productdesc  = eventsObject?["description"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let productPrice  = eventsObject?["price"] as! Double
                    let productKey = c.key.description as NSString
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String)
                    self.allCat.append(oneProduct)
                    print("one product is")
                    print(oneProduct)
                }
            }
        })
        self.ProductsCollectionView.reloadData()
}
    func addCat(name : String) -> Void {
        selectedSegment.insertSegment(withTitle: catNames[i-1] , at: i, animated: true)
        i += 1
        selectedSegment.selectedSegmentIndex = 0
        ProductsCollectionView.reloadData()
    }
    func fillItems() -> Void {
        let ref2 = Database.database().reference().child("Categories").child(self.catNames[selectedSegment.selectedSegmentIndex - 1])
        ref2.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productdesc  = eventsObject?["description"] as! String
                     let productinv  = eventsObject?["inventory"] as! Int
                    let productPrice  = eventsObject?["price"] as! Double
                    let productKey = c.key.description as NSString
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String)
                    self.category.append(oneProduct)
                  //  self.allCat.append(oneProduct)
                }
            }
        })
    }
    func fillAllItems() -> Void {
        let ref2 = Database.database().reference().child("Categories").childByAutoId()
        ref2.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productdesc  = eventsObject?["description"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let productPrice  = eventsObject?["price"] as! Double
                    let productKey = c.key.description as NSString
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String)
                    self.allCat.append(oneProduct)
                }
            }
        })
    }
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (6)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 3
        
        return CGSize(width: widthPerItem, height: widthPerItem )
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let controller = segue.destination as! ProductDetailsViewController
           if let indexPath1 = self.ProductsCollectionView.indexPathsForSelectedItems {
            let indexPath : IndexPath = indexPath1[0] as IndexPath
                
                switch (selectedSegment.selectedSegmentIndex)
                {

                case 0 :
                    controller.productInfo = self.allCat[indexPath.row]
                case 1 :
                     controller.productInfo = self.cat1[indexPath.row]
                case 2 :
                     controller.productInfo = self.cat2[indexPath.row]
                case 3 :
                     controller.productInfo = self.cat3[indexPath.row]
                case 4 :
                     controller.productInfo = self.cat4[indexPath.row]
                case 5 :
                     controller.productInfo = self.cat5[indexPath.row]
                case 6 :
                     controller.productInfo = self.cat6[indexPath.row]
                case 7 :
                     controller.productInfo = self.cat7[indexPath.row]
                case 8 :
                     controller.productInfo = self.cat8[indexPath.row]
                case 9 :
                     controller.productInfo = self.cat9[indexPath.row]
                case 10 :
                     controller.productInfo = self.cat10[indexPath.row]
                default :
                    controller.productInfo = self.allCat[indexPath.row]
                  
                }
            }
        }
          if segue.identifier == "shoppingCard" {
            let controller = segue.destination as! MakeReceiptViewController
            controller.shoppingCard = shoppingCard

            
        }
    }
}
extension UISegmentedControl {
    func removeBorders() {
       let c = UIColor(red: 0.6, green: 0.8314, blue: 0.9569, alpha: 1.0)
        setBackgroundImage(imageWithColor(color: UIColor.white), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: c), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        tintColor = UIColor.black
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
    
   
}
