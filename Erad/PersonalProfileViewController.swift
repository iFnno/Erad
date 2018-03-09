//
//  PersonalProfileViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/6/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class PersonalProfileViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    var started = false
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var hours : Int! = 0
    var minutes : Int! = 0
    var seconds : Int! = 0
    var isRunnnig = false
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Dovary additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if startedAlready == true  {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let x = String(formatter.string(from: date))
            self.dateLabel.text = x
            self.hours = 0
            self.minutes = 0
            self.seconds = 0
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            let startTime1 = formatter.date(from: startTime)!
            let units: Set<Calendar.Component> = [.hour, .minute, .second]
            let difference = Calendar.current.dateComponents(units, from: startTime1, to: date)
            self.hours = difference.hour!
            self.minutes = difference.minute!
            self.seconds = difference.second!
            secondsLabel.text = String(self.seconds)
            minutesLabel.text = String(self.minutes)
            hoursLabel.text = String(self.hours)
            self.run()
            
        }
    }
    func run() -> Void {
        if !self.isRunnnig {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PersonalProfileViewController.action), userInfo: nil, repeats: true)
            self.isRunnnig = true
            
        }
    }
    
    @objc func action()
    {
        seconds = seconds + 1
        secondsLabel.text = String(seconds)
        
        if seconds == 60 {
            seconds = 0
            minutes = minutes + 1
            secondsLabel.text = String(seconds)
            minutesLabel.text = String(minutes)
        }
        if minutes == 60 {
            minutes = 0
            hours = hours + 1
            minutesLabel.text = String(minutes)
            hoursLabel.text = String(hours)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
@IBAction func logoutButton(_ sender: UIButton) {
    if Auth.auth().currentUser != nil {
        do {
            try Auth.auth().signOut()
            let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            self.present(ViewController, animated: true, completion: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }}
    
    @IBAction func workTime(_ sender: Any) {
        performSegue(withIdentifier: "timeSeg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timeSeg" {
            let controller = segue.destination as! WorkTimeViewController
            controller.fromTab = true
            
        }
    }
}
