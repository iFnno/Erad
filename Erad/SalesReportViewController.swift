//
//  SalesReportViewController.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class SalesReportViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var salesTable: UITableView!
    
    @IBOutlet weak var totalSalesLabel: UILabel!
    
    @IBOutlet weak var totalQuantLabel: UILabel!
    
    var salesList : [ReportReceipt] = []
    var perfList : [salesObject] = []
    var pickerData: [[String]] = [[String]]()
    var month : String! = ""
    var year : String! = ""
    var ref : DatabaseReference!
    var ref1 : DatabaseReference!
    var userID : String! = ""
    var allPrices : Double! = 0.0
    var allQuan  : Int! = 0
    var quan  : Int! = 0

    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = [["January", "February", "March", "April","May","June","July","August","September","October","November","December"],
                      ["2018", "2019", "2020", "2021","2022","2023","2024","2025","2026","2027","2028","2029"]]
        self.ref1 = Database.database().reference().child(companyName)
        self.userID = (Auth.auth().currentUser?.uid.description)!
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let ye = String(formatter.string(from: date))
        formatter.dateFormat = "MM"
        let mo = String(formatter.string(from: date))
        switch mo {
        case "01":
            self.picker.selectRow(0, inComponent: 0, animated: true)
            break
        case "02":
            self.picker.selectRow(1, inComponent: 0, animated: true)
            break
        case "03":
            self.picker.selectRow(2, inComponent: 0, animated: true)
            break
        case "04":
            self.picker.selectRow(3, inComponent: 0, animated: true)
            break
        case "05":
            self.picker.selectRow(4, inComponent: 0, animated: true)
            break
        case "06":
            self.picker.selectRow(5, inComponent: 0, animated: true)
            break
        case "07":
            self.picker.selectRow(6, inComponent: 0, animated: true)
            break
        case "08":
            self.picker.selectRow(7, inComponent: 0, animated: true)
            break
        case "09":
            self.picker.selectRow(8, inComponent: 0, animated: true)
            break
        case "10":
            self.picker.selectRow(9, inComponent: 0, animated: true)
            break
        case "11":
            self.picker.selectRow(10, inComponent: 0, animated: true)
            break
        case "12":
            self.picker.selectRow(11, inComponent: 0, animated: true)
            break
            
        default:
            self.picker.selectRow(0, inComponent: 0, animated: true)
        }
        switch ye {
        case "2018":
            self.picker.selectRow(0, inComponent: 1, animated: true)
            break
        case "2019":
            self.picker.selectRow(1, inComponent: 1, animated: true)
            break
        case "2020":
            self.picker.selectRow(2, inComponent: 1, animated: true)
            break
        case "2021":
            self.picker.selectRow(3, inComponent: 1, animated: true)
            break
        case "2022":
            self.picker.selectRow(4, inComponent: 1, animated: true)
            break
        case "2023":
            self.picker.selectRow(5, inComponent: 1, animated: true)
            break
        case "2024":
            self.picker.selectRow(6, inComponent: 1, animated: true)
            break
        case "2025":
            self.picker.selectRow(7, inComponent: 1, animated: true)
            break
        case "2026":
            self.picker.selectRow(8, inComponent: 1, animated: true)
            break
        case "2027":
            self.picker.selectRow(9, inComponent: 1, animated: true)
            break
        case "2028":
            self.picker.selectRow(10, inComponent: 1, animated: true)
            break
        case "2029":
            self.picker.selectRow(11, inComponent: 1, animated: true)
            break
            
        default:
            self.picker.selectRow(0, inComponent: 1, animated: true)
        }
        self.loadReport()
        self.totalQuantLabel.text = ""
        self.totalSalesLabel.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            if self.perfList.count == 0 {
                self.createAlert(title: "لا يوجد محتوى", message: "لا يوجد معلومات متعلقة بهذا التاريخ" )
            }
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView( _ itemsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
       return perfList.count
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "salesCell", for: indexPath) as! SalesReportTableViewCell
            
            cell.selectionStyle = .none
            cell.day.text = self.perfList[indexPath.row].day
            cell.quantity.text = String(self.perfList[indexPath.row].totalQuantity)
            cell.price.text = String(self.perfList[indexPath.row].totalPrice)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.salesTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        self.salesList.removeAll()
        self.perfList.removeAll()
        self.salesTable.reloadData()
        loadReport()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            if self.perfList.count == 0 {
            self.createAlert(title: "لا يوجد محتوى", message: "لا يوجد معلومات متعلقة بهذا التاريخ" )
        }
        }
    }
    func loadReport() {
        self.perfList.removeAll()
        self.salesList.removeAll()
       self.allPrices = 0.0
        self.allQuan = 0
        let m = self.picker.selectedRow(inComponent: 0)
        let y = self.picker.selectedRow(inComponent: 1)
        switch m {
        case 0:
            self.month = "01"
            break
        case 1:
            self.month = "02"
            break
        case 2:
            self.month = "03"
            break
        case 3:
            self.month = "04"
            break
        case 4:
            self.month = "05"
            break
        case 5:
            self.month = "06"
            break
        case 6:
            self.month = "07"
            break
        case 7:
            self.month = "08"
            break
        case 8:
            self.month = "09"
            break
        case 9:
            self.month = "10"
            break
        case 10:
            self.month = "11"
            break
        case 11:
            self.month = "12"
            break
        default:
            self.month = "01"
            
        }
        switch y {
        case 0:
            self.year = "2018"
            break
        case 1:
            self.year = "2019"
            break
        case 2:
            self.year = "2020"
            break
        case 3:
            self.year = "2021"
            break
        case 4:
            self.year = "2022"
            break
        case 5:
            self.year = "2023"
            break
        case 6:
            self.year = "2024"
            break
        case 7:
            self.year = "2025"
            break
        case 8:
            self.year = "2026"
            break
        case 9:
            self.year = "2027"
            break
        case 10:
            self.year = "2028"
            break
        case 11:
            self.year = "2029"
            break
        default:
            self.year = "2018"
            
        }
        self.ref = Database.database().reference().child(companyName).child("receipts")
        ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.salesList.removeAll()
                self.perfList.removeAll()
                //iterating through all the values
                for receipt in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let eventsObject = receipt.value as? [String: AnyObject]
                    let rdate = eventsObject?["date"] as! String
                    let rtotalp = eventsObject?["totalPrice"] as! Double
                    let employeeID = eventsObject?["employeeID"] as! String
                    let recKey = receipt.key.description as NSString
                    
                    //appending to list
                    //receipt.products = self.Rproducts
                    let bol = ( self.userID == employeeID )
                    let receipt = ReportReceipt(date: rdate, totalPrice: rtotalp, employeeID: employeeID, key: recKey as String)
                    print(receipt)
                    if bol {
                        self.salesList.append(receipt)
                }

                
                }}})
       
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            if self.salesList.count > 0 {
                for rec in self.salesList {
        
        let dat = rec.date ?? "2018-01-01"
            let delimiter = "-"
            var token = dat.components(separatedBy: delimiter)
            print ()
            let year1 = token[0]
            let month1 = token[1]
            let day1 = token[2]
            
            if self.year == year1 && self.month == month1 {
                self.allPrices = self.allPrices + rec.totalPrice
                self.ref1.child("receipts").child(rec.key).child("products").observe(DataEventType.value, with: { (snapshot1) in
                    //if the reference have values
                    if snapshot1.childrenCount > 0 {
                        //clearing the list self.items.removeAll()
                        self.quan = 0
                        //iterating through all the values
                        for receipt in snapshot1.children.allObjects as! [DataSnapshot] {
                            //getting values
                            let eventsObject1 = receipt.value as? [String: AnyObject]
                            let quantity = eventsObject1?["quantity"] as! Int
                            self.quan = self.quan + quantity
                            self.allQuan = self.allQuan + quantity
            }
                        
                        let saleOb = salesObject(totalPrice: rec.totalPrice , totalQuantity: self.quan, day: day1)
                        self.perfList.append(saleOb)
                        self.salesTable.reloadData()
            
        }
                  
                })

        
        
    }
        }
                self.totalSalesLabel.text = String(self.allPrices)
                self.totalQuantLabel.text = String(self.allQuan)
        }
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
}
