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

class EditProfileViewController: UIViewController , UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var firstName : String! = ""
    var lastName : String! = ""
    var phoneNum : String! = ""
    var img : UIImage!
    var email : String! = ""
    var ref : DatabaseReference!
    var ref2 : DatabaseReference!
    var ref3 : DatabaseReference!
    var picURL : String! = ""
    var picName : String! = ""
    var managerEmail : String! = ""
    var employeeEmail : String! = ""
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBAction func editButton(_ sender: Any) {
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profilePictures")
        self.picName = imageName + ".jpg"
        let storeImage = storageRef.child(imageName)
        
        if let uploadImageData = UIImagePNGRepresentation((imgView.image)!){
            storeImage.putData(uploadImageData, metadata: nil, completion: { (metaData, error) in
                storeImage.downloadURL(completion: { (url, error) in
                     let urlText = url?.absoluteString
                        
                        self.picURL = urlText
                        print("///////////tttttttt//////// \(self.picURL)   ////////")
                        
                    
                })
            })
        }
    
    /*    let storageRef = Storage.storage().reference().child("\(imageName).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        if let uploadData = UIImagePNGRepresentation(self.imgView.image!) {
            
            storageRef.putData(uploadData, metadata: metaData) { (metadata, error) in
                guard metadata != nil else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metaData.downloadURL()
                print(downloadURL)
                self.picURL = String(describing: downloadURL)
            }
        } */
    
            
          self.firstName = self.firstNameField.text
          self.lastName = self.lastNameField.text
          self.phoneNum = self.phoneField.text
        
        if(self.firstName.isEmpty || self.lastName .isEmpty || self.phoneNum.isEmpty){
            var myalert = UIAlertController(title: " حقول فارغة" ,
                                            message : "الرجاء التحقق من تعبئة كل الحقول",
                                            preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "حسناً", style: .cancel, handler: nil)
            myalert.addAction(defaultAction)
            
            self.present(myalert, animated: true, completion: nil)
            return
        } else {

            
            
        //update
            self.ref2 = Database.database().reference().child(companyName)
            self.ref2.child("manager").observeSingleEvent(of: .value, with: { (snapshot) in
                let email4 = snapshot.childSnapshot(forPath: "email").value as! String
                self.managerEmail = email4
            })
            print("manager email")
            print(self.managerEmail)
            let userID = (Auth.auth().currentUser?.uid.description)!
            self.ref2.child("employees").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                let email4 = snapshot.childSnapshot(forPath: "email").value as! String
                self.employeeEmail = email4
            })

            if self.managerEmail == self.employeeEmail {
                self.ref = Database.database().reference().child(companyName).child("employees")
                self.ref3 = Database.database().reference().child(companyName).child("manager")
                let key = self.ref.child(userID)
                let key2 = self.ref3
                let post = ["firstName": self.firstName,
                            "lastName": self.lastName,
                            "phone": self.phoneNum] as [String : Any]
                let post2 = ["fname": self.firstName,
                             "lname": self.lastName,
                             "phone": self.phoneNum] as [String : Any]
                key.updateChildValues(post)
                key2?.updateChildValues(post2)
            } else {
                self.ref = Database.database().reference().child(companyName).child("employees")
                let key = self.ref.child(userID)
                let post = ["firstName": self.firstName,
                            "lastName": self.lastName,
                            "phone": self.phoneNum] as [String : Any]
                key.updateChildValues(post)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 30.0){
                if self.managerEmail == self.employeeEmail {
                    self.ref = Database.database().reference().child(companyName).child("employees")
                    self.ref3 = Database.database().reference().child(companyName).child("manager")
                    let key = self.ref.child(userID)
                    let key2 = self.ref3
                    let post = ["picPATH":self.picURL,
                                "picName":self.picName] as [String : Any]
                    let post2 = ["picPath":self.picURL,
                                 "picName":self.picName] as [String : Any]
                    key.updateChildValues(post)
                    key2?.updateChildValues(post2)
                } else {
                    self.ref = Database.database().reference().child(companyName).child("employees")
                    let key = self.ref.child(userID)
                    let post = ["picPATH":self.picURL,
                                "picName":self.picName] as [String : Any]
                    key.updateChildValues(post)
                }
            }
        var myalert = UIAlertController(title: "تم التعديل بنجاح" ,
                                        message : "تم تعديل معلوماتك الشخصية بنجاح",
                                        preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "حسناً", style: .default) { (action:UIAlertAction!) in
                
                // Code in this block will trigger when OK button tapped.
                startedAlready = false
              
                
                
                
                
                
                _ = self.navigationController?.popViewController(animated: true)
                let previousViewController = self.navigationController?.viewControllers.last as! PersonalProfileViewController
            }
        myalert.addAction(defaultAction)
        
        self.present(myalert, animated: true, completion: nil)
    }
    
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.phoneField.delegate = self
        self.imgView.image = self.img
        self.firstNameField.text = self.firstName
        self.lastNameField.text = self.lastName
        self.phoneField.text = self.phoneNum
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: self.email!, completion: { (error) in
            
            var title = ""
            var message = ""
            
            if error != nil {
                title = "خطأ"
                message = (error?.localizedDescription)!
            } else {
                title = "شكرا"
                message = "تم ارسال بريد إعادة تعيين كلمة المرور الى البريد الإلكتروني الخاص بك"
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "حسنا", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func changePic(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            self.img = image
            imgView.image = img
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 10
    }
}
