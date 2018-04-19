//
//  WorkTimeViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/1/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
var startedAlready = false
var globalMin = 0
var globalSec = 0
var globalhour = 0
var startTime : String! = "2017/12/12 00:00:00"
class WorkTimeViewController: UIViewController {

    var timer = Timer()
    var isRunnnig = false
    var min = 0
    var hour = 0
    var secon = 0
    var date : String! = ""
    var fromTab = false
    var totalTime : String! = ""
    var ref : DatabaseReference!
    
    @IBOutlet weak var todayDate: UILabel!
    
    @IBOutlet weak var later: UIButton!
    @IBAction func laterButton(_ sender: Any) {
        performSegue(withIdentifier: "tabSeg", sender: self)
    }
    @IBOutlet weak var seconds: UILabel!
    
    @IBOutlet weak var minutes: UILabel!
    
    @IBOutlet weak var hours: UILabel!
    
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    @IBOutlet weak var start: UIButton!
    
    @IBAction func start(_ sender: Any) {
        startedAlready = true // 1
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let timeToAppend = String(formatter.string(from: date))
        startTime = timeToAppend
        print("start")
        print(timeToAppend)
        print(startTime)
        run()
            self.start.isEnabled = false
            self.start.backgroundColor = UIColor(red: 0.8667, green: 0.8667, blue: 0.8667, alpha: 1)
        if self.fromTab == false {
            self.performSegue(withIdentifier: "tabSeg", sender: self)
        }

    }
    func run() -> Void {
         if !self.isRunnnig {
         self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkTimeViewController.action), userInfo: nil, repeats: true)
            self.isRunnnig = true

        }
    }

    
    @IBAction func reset(_ sender: Any) {
        if hour == 0  && min == 0 && secon == 0 {
            
        } else {
        let alertController = UIAlertController(title: "إنهاء وقت العمل", message: "هل انت متأكد من  إنهائك وقت العمل؟ ", preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING OK BUTTON
        
        let OKAction = UIAlertAction(title: "نعم", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            startedAlready = false
            self.totalTime = String(self.hour) + ":" + String(self.min) + ":" + String(self.secon)
            self.secon = 0
            self.min = 0
            self.hour = 0
            self.seconds.text = "00"
            self.minutes.text = "00"
            self.hours.text = "00"
            self.timer.invalidate()
            self.start.isEnabled = true
            self.start.backgroundColor = UIColor(red: 0.6, green: 0.8314, blue: 0.9569, alpha: 1.0)
            self.isRunnnig = false
            
            let userID = (Auth.auth().currentUser?.uid.description)!
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let todaysDate = String(formatter.string(from: date))
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let currentTime = String(formatter.string(from: date))
            formatter.dateFormat = "yyyy"
            let year1 = String(formatter.string(from: date))
            formatter.dateFormat = "MM"
            let month1 = String(formatter.string(from: date))
            formatter.dateFormat = "dd"
            let day1 = String(formatter.string(from: date))
            
            
            self.ref = Database.database().reference().child(companyName)
            self.ref.child("employees").child(userID).child("workingTime").child(year1).child(month1).child(day1).childByAutoId().setValue(["checkIn": startTime,"checkOut": currentTime ,"totalShiftTime": self.totalTime])
            
            startTime = "00:00:00"

            
            
            

            _ = self.navigationController?.popViewController(animated: true)
            let previousViewController = self.navigationController?.viewControllers.last as! PersonalProfileViewController
            previousViewController.started = false
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "تراجع", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
        
    }
    }
    
    @objc func action()
    {
            secon = secon + 1
            seconds.text = String(secon)
            
            if secon == 60 {
                secon = 0
                min = min + 1
                seconds.text = String(secon)
                minutes.text = String(min)
            }
            if min == 60 {
                min = 0
                hour = hour + 1
                minutes.text = String(min)
                hours.text = String(hour)
            }
            

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.additionalSafeAreaInsets.top = 20
        }
        if self.fromTab == true {
            self.later.isHidden = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        self.hour = 0
        self.min = 0
        self.secon = 0
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = String(formatter.string(from: date))
        self.todayDate.text = self.date
       if startedAlready == true {
         let date = Date()
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
         let startTime1 = formatter.date(from: startTime)!
         let units: Set<Calendar.Component> = [.hour, .minute, .second]
         let difference = Calendar.current.dateComponents(units, from: startTime1, to: date)
         self.hour = difference.hour!
         self.min = difference.minute!
         self.secon = difference.second!
         seconds.text = String(self.secon)
         minutes.text = String(self.min)
         hours.text = String(self.hour)
        self.run()
        self.start.isEnabled = false
        self.start.backgroundColor = UIColor(red: 0.8667, green: 0.8667, blue: 0.8667, alpha: 1)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabSeg" {
            let controller = segue.destination as! MyTabBarController
            
        }
    }
/*    override func viewWillDisappear(_ animated: Bool) {
        if self.fromTab == true {
        let previousViewController = self.navigationController?.viewControllers.last as! PersonalProfileViewController
       // previousViewController.started = startedAlready
    }
} */
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
                subview.backgroundColor = UIColor.white //UIColor(red: 0.9373, green: 0.9373, blue: 0.9373, alpha: 1.0)

            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 5 , width: subview.frame.width, height: customHeight)
                subview.backgroundColor = UIColor.white //UIColor(red: 0.9373, green: 0.9373, blue: 0.9373, alpha: 1.0)
                subview.layer.masksToBounds = false
                subview.layer.shadowColor = UIColor.gray.cgColor
                subview.layer.shadowOpacity = 0.1
                subview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                subview.layer.shadowRadius = 1
            }
        }
    }

    
}
public class makeAlert {
    class func ShowAlert(title: String, message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "حسناً", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}

