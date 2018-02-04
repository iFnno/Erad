//
//  WorkTimeViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/1/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit

class WorkTimeViewController: UIViewController {
    var secon = 0
    var timer = Timer()
    var isRunnnig = false
    var min = 0
    var hour = 0
    @IBOutlet weak var seconds: UILabel!
    
    @IBOutlet weak var minutes: UILabel!
    
    @IBOutlet weak var hours: UILabel!
    
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    @IBOutlet weak var start: UIButton!
    
    @IBAction func start(_ sender: Any) {
        if !isRunnnig {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkTimeViewController.action), userInfo: nil, repeats: true)
            start.isEnabled = false
            self.start.backgroundColor = UIColor(red: 0.8667, green: 0.8667, blue: 0.8667, alpha: 1)
            isRunnnig = true
        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        
        if hour == 0  && min == 0 && secon == 0 {
            
            } else {
        secon = 0
        min = 0
        hour = 0
        seconds.text = "00"
        minutes.text = "00"
        hours.text = "00"
        timer.invalidate()
        start.isEnabled = true
            self.start.backgroundColor = UIColor(red: 0.6, green: 0.8314, blue: 0.9569, alpha: 1.0)
        isRunnnig = false
    }
    }
    
    @objc func action()
    {
        secon += 1
        seconds.text = String(secon)
        
        if secon == 60 {
            secon = 0
            min += 1
            seconds.text = String(secon)
            minutes.text = String(min)
        }
        if min == 60 {
            min = 0
            hour += 1
            minutes.text = String(min)
            hours.text = String(hour)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds.text = "00"
        minutes.text = "00"
        hours.text = "00"
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets.top = 20
        }
    }
}
class CustomNavigationBar: UINavigationBar {
    
    // NavigationBar height
    var customHeight : CGFloat = 48
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let y = UIApplication.shared.statusBarFrame.height
        frame = CGRect(x: frame.origin.x, y:  y, width: frame.size.width, height: customHeight)
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = UIColor(red: 0.9373, green: 0.9373, blue: 0.9373, alpha: 1.0)
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 5 , width: subview.frame.width, height: customHeight)
                subview.backgroundColor = UIColor(red: 0.9373, green: 0.9373, blue: 0.9373, alpha: 1.0)
            }
        }
    }
}


