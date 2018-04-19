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
class ProductsMenuViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource , UISearchBarDelegate {
    var ref: DatabaseReference!
    var childIndex : Int! = 0
    @IBOutlet weak var ProductsCollectionView: UICollectionView! /* {
        didSet {
            ProductsCollectionView.delegate = self
            ProductsCollectionView.dataSource = self
        }
    } */
    

    var refreshControl: UIRefreshControl!
    var shoppingCard : [ShoppingCardItem] = []
     var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var currentShoppingCardButton: UIButton!
    
    @IBAction func currentShoppingCardButton(_ sender: Any) {
            self.performSegue(withIdentifier: "shoppingCard", sender: self)
    }
    @objc func goInventory() {
        performSegue(withIdentifier: "invSeg", sender: self)
        
    }
    
    
    
  //  var selectedProduct : Product = Product(pname: "", img: #imageLiteral(resourceName: "Logo.png"), inventory: 0, price: 0, desc: "")
    @IBOutlet weak var scrollview: UIScrollView!
    var category : [Product] = []
    var inventoryArray : [Product] = []
    var catNames : [String] = []
    var catNumbers : [Int] = []
    var allCat : [Product] = []
    var filterAllCat = [Product]()
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
    var UpdatedItemQuanitity : ShoppingCardItem! = ShoppingCardItem(pname: "", quantity: 0, price: 0.0, pID: "", category: "", cost: 0.0)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        switch (selectedSegment.selectedSegmentIndex)
        {
        case 0 :
            if(searchActive) {
                returnValue = filterAllCat.count
            }
            else {
                returnValue = allCat.count
            }
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
            if(searchActive){
                cell.ProductName.text = self.filterAllCat[indexPath.row].pname
                cell.imgView.image = self.filterAllCat[indexPath.row].image
            }
            else {
             //   fillAllItems()
                cell.ProductName.text = self.allCat[indexPath.row].pname
                    cell.imgView.image = self.allCat[indexPath.row].image
            }
        case 1 :
                cell.ProductName.text = cat1[indexPath.row].pname
               cell.imgView.image = self.cat1[indexPath.row].image
            

        case 2 :
           
                cell.ProductName.text = cat2[indexPath.row].pname
               cell.imgView.image = self.cat2[indexPath.row].image
            
        case 3 :
          
                cell.ProductName.text = cat3[indexPath.row].pname
                cell.imgView.image = self.cat3[indexPath.row].image
            
        case 4 :
           
                cell.ProductName.text = cat4[indexPath.row].pname
                cell.imgView.image = self.cat4[indexPath.row].image
            
        case 5 :
          
                cell.ProductName.text = cat5[indexPath.row].pname
                cell.imgView.image = self.cat5[indexPath.row].image
            
        case 6 :
          
                cell.ProductName.text = cat6[indexPath.row].pname
                cell.imgView.image = self.cat6[indexPath.row].image
            
        case 7 :
            
                cell.ProductName.text = cat7[indexPath.row].pname
                cell.imgView.image = self.cat7[indexPath.row].image
            
        case 8 :
            
                cell.ProductName.text = cat8[indexPath.row].pname
                cell.imgView.image = self.cat8[indexPath.row].image
            
        case 9 :
          
                cell.ProductName.text = cat9[indexPath.row].pname
                cell.imgView.image = self.cat9[indexPath.row].image
            
            
        case 10 :
           
                cell.ProductName.text = cat10[indexPath.row].pname
                cell.imgView.image = self.cat10[indexPath.row].image
            
            
        default:
            cell.ProductName.text = allCat[indexPath.row].pname
            cell.imgView.image = self.allCat[indexPath.row].image
            
            
         
        }
        activityIndicator.stopAnimating()
        return cell
    }
    
    var i : Int = 1
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    @IBAction func selectedSegment(_ sender: Any) {
        self.ProductsCollectionView.reloadData()
        if selectedSegment.selectedSegmentIndex != 0 {
            self.searchBar.isHidden = true
        } else {
            self.searchBar.isHidden = false
        }
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func viewDidAppear(_ animated: Bool) {
        if shoppingCard.count != 0 {
            self.currentShoppingCardButton.isHidden = false
 }
        if self.UpdatedItemQuanitity.quantity != 0 {
            var i = 0
            for ind in shoppingCard {
                if self.UpdatedItemQuanitity.pID == ind.pID {
                    let quant = self.UpdatedItemQuanitity.quantity + ind.quantity
                    shoppingCard[i].quantity = quant
                    self.UpdatedItemQuanitity.quantity = quant
                    //shoppingCard.append(self.UpdatedItemQuanitity)
                    self.UpdatedItemQuanitity = ShoppingCardItem(pname: "", quantity: 0, price: 0.0, pID: "", category: "", cost: 0.0)
                }
                i = i + 1
            }
            i = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "قائمة المنتجات"
        self.navigationController?.navigationBar.barStyle  = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
        self.navigationController?.navigationBar.clearsContextBeforeDrawing = true
        let color = UIColor(red: 0.2863, green: 0.5373, blue: 0.6471, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = color
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.currentShoppingCardButton.isHidden = true

        let image = UIImage(named: "Menu1.png")
        let button = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.plain, target: self.splitViewController!.displayModeButtonItem.target, action: self.splitViewController!.displayModeButtonItem.action)
        button.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = button
        let image2 = UIImage(named: "inventory.png")
        let button2 = UIBarButtonItem.init(image: image2, style: UIBarButtonItemStyle.plain, target: self, action: #selector(goInventory))
        button2.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = button2
        searchBar.delegate = self
        selectedSegment.removeAllSegments()
        selectedSegment.insertSegment(withTitle: "الكل" , at: i, animated: true)
        ref = Database.database().reference().child(companyName).child("products")
        ref.observe(DataEventType.value, with: { (snapshot) in
         if snapshot.childrenCount > 0 && self.catNames == [] {
            self.catNumbers.removeAll()
            self.catNames.removeAll()
            self.i = 1
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
        let c = UIColor(hue: 0.55, saturation: 0.55, brightness: 0.64, alpha: 1.0)
        selectedSegment.setTitleTextAttributes([NSAttributedStringKey.font: font2 as Any , NSAttributedStringKey.foregroundColor: c],
                                               for: .selected)
         selectedSegment.selectedSegmentIndex = 0
        let ref2 = Database.database().reference().child(companyName).child("products")
        ref2.observe(DataEventType.childAdded, with: { (snapshot) in
            self.childIndex = self.childIndex + 1
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productdesc  = eventsObject?["description"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let productPrice  = eventsObject?["price"] as! Double
                    let productCategory = eventsObject?["category"] as! String
                    let cost  = eventsObject?["cost"] as! Double
                    let productKey = c.key.description as NSString
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String, category: productCategory, cost: cost)
                    let inP = Product(pname: productName, img: img1, inventory: productinv, pID: productKey as String, category: productCategory, cost: cost)
                    self.allCat.append(oneProduct)
                    self.inventoryArray.append(inP)
                    switch (self.childIndex)
                    {
                    case 1 :
                        self.cat1.append(oneProduct)
                    case 2 :
                        self.cat2.append(oneProduct)
                    case 3 :
                        self.cat3.append(oneProduct)
                    case 4 :
                        self.cat4.append(oneProduct)
                    case 5 :
                        self.cat5.append(oneProduct)
                    case 6 :
                        self.cat6.append(oneProduct)
                    case 7 :
                        self.cat7.append(oneProduct)
                    case 8 :
                        self.cat8.append(oneProduct)
                    case 9 :
                        self.cat9.append(oneProduct)
                    case 10 :
                        self.cat10.append(oneProduct)
                        
                    default:
                        self.allCat.append(oneProduct)
                    }
                   
                }
            }
        })
        self.ProductsCollectionView.reloadData()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", for: UIControlEvents.valueChanged)
        ProductsCollectionView.addSubview(refreshControl)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 14.0){
            if self.allCat.count == 0 {
                self.createAlert(title: "لا يوجد محتوى", message: "لا يوجد معلومات لهذه الصفحة" )
            }
        }
}
    func refresh(sender:AnyObject) {
        // Code to refresh table view
        let ref2 = Database.database().reference().child(companyName).child("products")
        ref2.observe(DataEventType.childAdded, with: { (snapshot) in
            self.childIndex = self.childIndex + 1
            if snapshot.childrenCount > 0 {
                for c in snapshot.children.allObjects as! [DataSnapshot] {
                    let eventsObject = c.value as? [String: AnyObject]
                    let productName  = eventsObject?["name"] as! String
                    let productimg  = eventsObject?["picPath"] as! String
                    let productdesc  = eventsObject?["description"] as! String
                    let productinv  = eventsObject?["inventory"] as! Int
                    let productPrice  = eventsObject?["price"] as! Double
                    let productCategory = eventsObject?["category"] as! String
                    let cost  = eventsObject?["cost"] as! Double

                    let productKey = c.key.description as NSString
                    let url1 = URL(string: productimg)
                    let data1 = try? Data(contentsOf: url1! )
                    //NSData(contentsOf: url! as URL)
                    let img1 : UIImage = UIImage(data: data1! as Data)!
                    
                    let oneProduct = Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String, category: productCategory, cost: cost)
                        //Product(pname: productName, img: img1, inventory: productinv, price: productPrice, desc: productdesc, pID: productKey as String, category: productCategory, cost: cost)
                    let inP = Product(pname: productName, img: img1, inventory: productinv, pID: productKey as String, category: productCategory, cost: cost)
                     //   Product(pname: productName, img: img1, inventory: productinv, pID: productKey as String, category: productCategory, cost: cost)
                    self.allCat.append(oneProduct)
                    self.inventoryArray.append(inP)

                    switch (self.childIndex)
                    {
                    case 1 :
                        self.cat1.append(oneProduct)
                    case 2 :
                        self.cat2.append(oneProduct)
                    case 3 :
                        self.cat3.append(oneProduct)
                    case 4 :
                        self.cat4.append(oneProduct)
                    case 5 :
                        self.cat5.append(oneProduct)
                    case 6 :
                        self.cat6.append(oneProduct)
                    case 7 :
                        self.cat7.append(oneProduct)
                    case 8 :
                        self.cat8.append(oneProduct)
                    case 9 :
                        self.cat9.append(oneProduct)
                    case 10 :
                        self.cat10.append(oneProduct)
                        
                    default:
                        self.allCat.append(oneProduct)
                    }
                    
                }
            }})
                    self.ProductsCollectionView.reloadData()

    }
    
    func addCat(name : String) -> Void {
        selectedSegment.insertSegment(withTitle: catNames[i-1] , at: i, animated: true)
        i += 1
        selectedSegment.selectedSegmentIndex = 0
        ProductsCollectionView.reloadData()
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
                    if(searchActive) {
                        controller.productInfo = self.filterAllCat[indexPath.row]
                        controller.list = self.shoppingCard                    }
                    else {
                        controller.productInfo = self.allCat[indexPath.row]
                        controller.list = self.shoppingCard                    }
                    
                case 1 :
                     controller.productInfo = self.cat1[indexPath.row]
                    controller.list = self.shoppingCard
                case 2 :
                     controller.productInfo = self.cat2[indexPath.row]
                    controller.list = self.shoppingCard
                case 3 :
                     controller.productInfo = self.cat3[indexPath.row]
                    controller.list = self.shoppingCard
                case 4 :
                     controller.productInfo = self.cat4[indexPath.row]
                    controller.list = self.shoppingCard
                case 5 :
                     controller.productInfo = self.cat5[indexPath.row]
                    controller.list = self.shoppingCard
                case 6 :
                     controller.productInfo = self.cat6[indexPath.row]
                    controller.list = self.shoppingCard
                case 7 :
                     controller.productInfo = self.cat7[indexPath.row]
                    controller.list = self.shoppingCard
                case 8 :
                     controller.productInfo = self.cat8[indexPath.row]
                    controller.list = self.shoppingCard
                case 9 :
                     controller.productInfo = self.cat9[indexPath.row]
                    controller.list = self.shoppingCard
                case 10 :
                     controller.productInfo = self.cat10[indexPath.row]
                    controller.list = self.shoppingCard
                default :
                    controller.productInfo = self.allCat[indexPath.row]
                    controller.list = self.shoppingCard
                  
                }
            }
        }
          if segue.identifier == "shoppingCard" {
            let controller = segue.destination as! MakeReceiptViewController
            controller.shoppingCard = shoppingCard
            controller.paused = false
        }
        
        if segue.identifier == "invSeg" {
            let c = segue.destination as! InventoryViewController
            c.ProductsList = self.inventoryArray
        }
    }
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "حسناً", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterAllCat = allCat.filter({ (text) -> Bool in
            
            let temp1: NSString = " " + String(text.pname) + " " as NSString
            let temp2: NSString = text.description as NSString
            
            return (temp1.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                || (temp2.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        if((filterAllCat.count == 0)&&(searchText=="")){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.ProductsCollectionView?.reloadData()
        
    }


    
}
extension UISegmentedControl {
    func removeBorders() {
     //  let c = UIColor(red: 0.6, green: 0.8314, blue: 0.9569, alpha: 1.0)
        setBackgroundImage(imageWithColor(color: UIColor.white), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: UIColor.white), for: .selected, barMetrics: .default)
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
