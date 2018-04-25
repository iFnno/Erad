//
//  BasicBarChartViewController.swift
//  إيراد
//
//  Created by Afnan S on 4/23/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class BasicBarChartViewController: UIViewController {
    @IBOutlet weak var basicBarChart: BasicBarChart!
    @IBOutlet weak var barChart: BeautifulBarChart!
    var SalesList : [salesObject] = []
     var workingList : [TimeObject] = []
    var monthName : String! = ""
    var fromSales = false
    var fromWorkingHours = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.fromSales == true {
            self.title = "تقرير المبيعات الخاصة بك"
        }
        if self.fromWorkingHours == true {
           self.title = "تقرير ساعات العمل الخاصة بك"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        let dataEntries = generateDataEntries()
        basicBarChart.dataEntries = dataEntries
        barChart.dataEntries = dataEntries
    }
    
    func generateDataEntries() -> [BarEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        if self.fromSales == true {
        let x = self.SalesList.count
        for i in 0..<x {
            let value = (SalesList[i].totalQuantity % 90) //+ 10
            let height: Float = Float(value) / 100.0
            
            result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: self.SalesList[i].day + " " + self.monthName))
        }
            self.fromSales = false
        return result
    } else if self.fromWorkingHours == true {
            let x = self.workingList.count
            for i in 0..<x {
                let delimiter = ":"
                let tim = self.workingList[i].total
                var token =  tim?.components(separatedBy: delimiter)
                let hours = token![0]
                let minutes = token![1]

                let h = 60 * Int(hours)!
                
                let interval = h + Int(minutes)!
                
                let value = (interval % 90) + 10
                let height: Float = Float(value) / 100.0
                
                result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(hours) س", title: self.workingList[i].day + " " + self.monthName))
            }
            self.fromWorkingHours = false
            return result
        }
        
            let arr : [BarEntry] = []
            return arr
    }
    
}
