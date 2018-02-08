//
//  ProductsMenuViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
var num : Int = 3
class ProductsMenuViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource {
    
    @IBOutlet weak var ProductsCollectionView: UICollectionView! {
        didSet {
            ProductsCollectionView.delegate = self
            ProductsCollectionView.dataSource = self
        }
    }
    
    var selectList : [String] = ["ff"]
    var pinsList : [String] = ["قلم احمر" , "قلم اخضر" , "قلم ازرق" , "قلم اسود"]
    var PrintersList : [String] = ["ديل" , "اتش بي" , "توشيبا"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.ProductName.text = selectList[indexPath.row]
        return cell
    }
    
    var i : Int = 0
    var list : [String] = [ "الاقلام" , "الطابعات" , "الدفاتر" , "الملفات" , "الاقلام" , "الاقلام" , "الاقلام" , "الاقلام" , "الاقلام" , "الاقلام" ]
    var EngList : [String] = ["pinsList","PrintersList"]
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    
    @IBAction func selectedSegment(_ sender: Any) {
        let s = EngList[selectedSegment.selectedSegmentIndex]
        selectList = [s] as [ String]
        print(self.ProductsCollectionView.numberOfSections)
        ProductsCollectionView.reloadData()
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSegment.removeAllSegments()
      //  selectedSegment.apportionsSegmentWidthsByContent = true
        for ind in list {
        selectedSegment.insertSegment(withTitle: ind , at: i, animated: true)
            i += 1
        }
        selectedSegment.selectedSegmentIndex = 0
        selectedSegment.removeBorders()
        let desiredWidthChange = 2500.0
        
        self.widthConstraint.constant = CGFloat(desiredWidthChange)
        
        selectedSegment.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.selectedSegment.layoutIfNeeded()  // Captures all of the frame changes.
        })
        let font =  UIFont.systemFont(ofSize: 16.0)
        selectedSegment.setTitleTextAttributes([NSAttributedStringKey.font: font as Any],
                                                for: .normal)
        let font2 = UIFont.boldSystemFont(ofSize: 20.0)
        selectedSegment.setTitleTextAttributes([NSAttributedStringKey.font: font2 as Any],
                                               for: .selected)
        
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
