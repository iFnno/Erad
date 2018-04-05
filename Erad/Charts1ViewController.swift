//
//  Charts1ViewController.swift
//  إيراد
//
//  Created by Afnan S on 4/2/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import JBChart

class Charts1ViewController: UIViewController , JBBarChartViewDelegate, JBBarChartViewDataSource {
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return 7
    }
    

    @IBOutlet weak var barChart: JBBarChartView!
    @IBOutlet weak var informationLabel: UILabel!
    
    var chartLegend = ["11-14", "11-15", "11-16", "11-17", "11-18", "11-19", "11-20"]
    var chartData = [70, 80, 76, 88, 90, 69, 74]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.darkGray
        
        // bar chart setup
        barChart.backgroundColor = UIColor.darkGray
        barChart.delegate = self
        barChart.dataSource = self
        barChart.minimumValue = 0
        barChart.maximumValue = 100
        
        barChart.reloadData()
        
        barChart.setState(.collapsed, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var footerView = UIView(frame: CGRect(x: 0, y: 0, width: barChart.frame.width, height: 16))
        
        print("viewDidLoad: \(barChart.frame.width)")
        
        var footer1 = UILabel(frame: CGRect(x: 0, y: 0, width: barChart.frame.width/2 - 8, height: 16))
        footer1.textColor = UIColor.white
        footer1.text = "\(chartLegend[0])"
        
        var footer2 = UILabel(frame: CGRect(x: barChart.frame.width/2 - 8, y: 0, width: barChart.frame.width/2 - 8, height: 16))
        footer2.textColor = UIColor.white
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        var header = UILabel(frame: CGRect(x: 0, y: 0, width: barChart.frame.width, height: 50))
        header.textColor = UIColor.white
        header.font = UIFont.systemFont(ofSize: 24)
        header.text = "Weather: San Jose, CA"
        header.textAlignment = NSTextAlignment.center
        
        barChart.footerView = footerView
        barChart.headerView = header
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        barChart.reloadData()
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        barChart.setState(.collapsed, animated: true)
    }
    
    func showChart() {
        barChart.setState(.expanded, animated: true)
    }
    
    // MARK: JBBarChartView
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count)
    }
    
    internal func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        return (index % 2 == 0) ? UIColor.lightGray : UIColor.white
    }
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt) {
        let data = chartData[Int(index)]
        let key = chartLegend[Int(index)]
        
        informationLabel.text = "Weather on \(key): \(data)"
    }
    
    func didDeselectBarChartView(barChartView: JBBarChartView!) {
        informationLabel.text = ""
    }

}
