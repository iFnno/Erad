//
//  WorkingHoursReportViewController.swift
//  إيراد
//
//  Created by Afnan S on 3/25/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase

class WorkingHoursReportViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , UIPickerViewDelegate, UIPickerViewDataSource {

    

    
    @IBOutlet weak var hoursTable: UITableView!
    var workingList : [String] = []
    var pickerData: [[String]] = [[String]]()
    var month : String! = ""
    var year : String! = ""
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
            pickerData = [["January", "February", "March", "April","May","June","July","August","September","October","November","December"],
                          ["2018", "2019", "2020", "2021","2022","2023","2024","2025","2026","2027","2028","2029"]]
        
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView( _ itemsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workingList.count
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "hoursCell", for: indexPath) as! WorkingHoursReportTableViewCell
        
        /*   cell.selectionStyle = .none
         print("naaamee")
         print(self.pausedShoppingCard[indexPath.row].pname)
         cell.pName.text = self.pausedShoppingCard[indexPath.row].pname
         cell.Quantity.text = String(self.pausedShoppingCard[indexPath.row].quantity)
         cell.pamount.text = String(self.pausedShoppingCard[indexPath.row].price * Double(self.pausedShoppingCard[indexPath.row].quantity)) + " SR" */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.hoursTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
    }

    
    // The data to return for the row and component (column) that's being passed in
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func loadReport() {
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
        
        
        
    }
}
