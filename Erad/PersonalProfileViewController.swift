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
    
    @IBOutlet weak var proiflePic: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var phoneNum: UILabel!
    
    @IBAction func editProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "editSeg", sender: self)
    }
    var userN : String! = ""
    var fullN : String! = ""
    var firN : String! = ""
    var lasN : String! = ""
    var phone : String! = ""
    var ref3 : DatabaseReference!
    
    var hours : Int! = 0
    var minutes : Int! = 0
    var seconds : Int! = 0
    var isRunnnig = false
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "الملف الشخصي"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let x = String(formatter.string(from: date))
        self.dateLabel.text = x
        // Dovary additional setup after loading the view.
        let userID1 = (Auth.auth().currentUser?.uid.description)!
        ref3 = Database.database().reference().child(companyName)
        ref3.child("employees").child(userID1).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            let Fname  = value["firstName"] as! String
            let Lname = value["lastName"] as! String
            let pho = value["phone"] as! String
            let im = value["picPATH"] as! String
            let userna = value["username"] as! String
            let x = Fname + " " + Lname
            self.firN = Fname
            self.lasN = Lname
            self.fullN = x
            self.phone = pho
            self.userN = userna
            let url1 = URL(string: im)
            let data1 = try? Data(contentsOf: url1! )
            let img1 : UIImage = UIImage(data: data1! as Data)!
            self.proiflePic.image = img1
            self.fullName.text = self.fullN
            self.phoneNum.text = self.phone
            self.userName.text = self.userN
        })
        
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
        if startedAlready == false {
          timer.invalidate()
            secondsLabel.text = "0"
            minutesLabel.text = "0"
            hoursLabel.text = "0"
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
        if segue.identifier == "editSeg" {
            let controller = segue.destination as! EditProfileViewController
            controller.firstName = self.firN
            controller.lastName = self.lasN
            controller.userName = self.userN
            controller.phoneNum = self.phone
            controller.img = self.proiflePic.image
        }
    }
}
