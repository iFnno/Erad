//
//  EditProfileViewController.swift
//  إيراد
//
//  Created by Afnan S on 3/29/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditProfileViewController: UIViewController , UITextFieldDelegate{
    var firstName : String! = ""
    var lastName : String! = ""
    var userName : String! = ""
    var phoneNum : String! = ""
    var img : UIImage!
    var ref : DatabaseReference!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var userNameField: UITextField!
    
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBAction func editButton(_ sender: Any) {
          self.firstName = self.firstNameField.text
          self.lastName = self.lastNameField.text
          self.userName = self.userNameField.text
          self.phoneNum = self.phoneField.text
        
        if(self.firstName.isEmpty || self.lastName .isEmpty || self.userName.isEmpty || self.phoneNum.isEmpty){
            var myalert = UIAlertController(title: " حقول فارغة" ,
                                            message : "الرجاء التحقق من تعبئة كل الحقول",
                                            preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "حسناً", style: .cancel, handler: nil)
            myalert.addAction(defaultAction)
            
            self.present(myalert, animated: true, completion: nil)
            return
        } else {
        //update
        self.ref = Database.database().reference().child(companyName).child("employees")
            let userID = (Auth.auth().currentUser?.uid.description)!
            let key = self.ref.child(userID)
        let post = ["firstName": self.firstName,
                    "lastName": self.lastName,
                    "phone": self.phoneNum,
                    "username": self.userName] as [String : Any]
        key.updateChildValues(post)
        }
        var myalert = UIAlertController(title: "تم التعديل بنجاح" ,
                                        message : "تم تعديل معلوماتك الشخصية بنجاح",
                                        preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "حسناً", style: .cancel, handler: nil)
        myalert.addAction(defaultAction)
        
        self.present(myalert, animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.phoneField.delegate = self
        self.userNameField.delegate = self
        self.imgView.image = self.img
        self.firstNameField.text = self.firstName
        self.lastNameField.text = self.lastName
        self.userNameField.text = self.userName
        self.phoneField.text = self.phoneNum
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
