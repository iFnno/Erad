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

    
    @IBAction func BarChart(_ sender: Any) {
        self.performSegue(withIdentifier: "wChart", sender: self)
    }
    
    
    @IBOutlet weak var hoursTable: UITableView!
    var workingList : [TimeObject] = []
    var pickerData: [[String]] = [[String]]()
    var month : String! = ""
    var year : String! = ""
    var ref : DatabaseReference!
    var userID : String! = ""
    var totaltime : String! = ""
    var hour : Int = 0
    var min : Int = 0
    var sec : Int = 0
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var totalTmelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
            pickerData = [["January", "February", "March", "April","May","June","July","August","September","October","November","December"],
                          ["2018", "2019", "2020", "2021","2022","2023","2024","2025","2026","2027","2028","2029"]]
        self.ref = Database.database().reference().child(companyName)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            if self.workingList.count == 0 {
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
        return workingList.count
    }
    
    func tableView( _ itemsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "hoursCell", for: indexPath) as! WorkingHoursReportTableViewCell
           cell.selectionStyle = .none
        let start = self.workingList[indexPath.row].start
        let delimiter1 = " "
        var token = start?.components(separatedBy: delimiter1)
        cell.stratTime.text = token?[1]
        
        let end = self.workingList[indexPath.row].end
        var token1 = end?.components(separatedBy: delimiter1)
        cell.endTime.text = token1?[1]
        cell.totalTime.text = String(self.workingList[indexPath.row].total)
        cell.day.text = self.workingList[indexPath.row].day
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectionIndexPath = self.hoursTable.indexPathForSelectedRow {
            tableView.deselectRow(at: selectionIndexPath, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        self.workingList.removeAll()
        self.hoursTable.reloadData()
        loadReport()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            if self.workingList.count == 0 {
                self.createAlert(title: "لا يوجد محتوى", message: "لا يوجد معلومات متعلقة بهذا التاريخ" )
            }
        }
    }
    func loadReport() {
         self.workingList.removeAll()
        self.hour = 0
        self.min = 0
        self.sec = 0
        self.totaltime = String(self.hour) + ":" + String(self.min) + ":" + String(self.sec)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let date = dateFormatter.date(from: "2018-01-01 00:00:00")

        
        self.ref.child("employees").child(self.userID).child("workingTime").child(self.year).child(self.month).observe(DataEventType.value, with: { (snapshot1) in
            //if the reference have values
            if snapshot1.childrenCount > 0 {
                //clearing the list self.items.removeAll()
                self.workingList.removeAll()
                //iterating through all the values
                for days in snapshot1.children.allObjects as! [DataSnapshot] {
                    //getting values
                    if days.childrenCount > 0 {
                        for one in days.children.allObjects as! [DataSnapshot] {
                    let eventsObject1 = one.value as? [String: AnyObject]
                    let starts = eventsObject1?["checkIn"] as! String
                    let ends = eventsObject1?["checkOut"] as! String
                    let totals = eventsObject1?["totalShiftTime"] as! String
                            print(starts)
                            print(ends)
                            print(totals)
                            print(days.key.description)
                            let times = TimeObject(start: starts, end: ends, total: totals, day: days.key.description)
                            self.workingList.append(times)
                           
                       
                            let delimiter1 = ":"
                            var token1 = totals.components(separatedBy: delimiter1)
                             self.sec = self.sec + Int(token1[2])!
                            self.min = self.min + Int(token1[1])!
                            self.hour = self.hour + Int(token1[0])!
                           
                            
            }
            
        }
                }}
            self.hoursTable.reloadData()
            self.totaltime = String(self.hour) + ":" + String(self.min) + ":" + String(self.sec)
            let delimiter = ":"
            var token = self.totaltime.components(separatedBy: delimiter)
            let hours = token[0]
            let minutes = token[1]
            let seconds = token[2]
            print(hours)
            print(minutes)
            print(seconds)
            let h = 3600 * Int(hours)!
            let m = 60 * Int(minutes)!
            
            let interval = h + m + Int(seconds)!
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            let formattedString = formatter.string(from: TimeInterval(interval))!
            let token3 = formattedString.components(separatedBy: delimiter)
            if token3.count == 2 {
                self.totaltime = "0:" + formattedString
            } else {
              self.totaltime = formattedString
            }
            
            
            self.totalTmelabel.text = self.totaltime
        })
        
        self.hoursTable.reloadData()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wChart" {
            let controller = segue.destination as! Charts1ViewController
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
