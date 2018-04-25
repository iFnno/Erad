//
//  LoginViewController.swift
//  إيراد
//


import UIKit
import Firebase
import FirebaseAuth
var companyName : String! = ""
class LoginViewController:UIViewController , UITextFieldDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var ref: DatabaseReference!
    var found : Bool = false
    var flag : Bool = false
    @IBAction func loginButton(_ sender: UIButton) {
        //empty field
        if emailField.text == "" || passwordField.text == "" {
            self.createAlert(title:"خطأ", message: "الرجاء كتابة البريد الالكتروني وكلمة المرور")}
        else{
            let email2 = self.emailField.text!
            let pass2 = self.passwordField.text!
            Auth.auth().signIn(withEmail: email2, password: pass2) { (user, error) in
                if error == nil {
                    self.compayName()
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                else { self.createAlert(title: "خطأ", message: "الرجاء التأكد من صحة البريد الالكتروني و كلمة المرور")}
            }}}
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self as! UITextFieldDelegate
        passwordField.delegate = self as! UITextFieldDelegate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
                let controller = segue.destination as! WorkTimeViewController
            }
        if segue.identifier == "forget" {
            let controller = segue.destination as! ResetPasswordViewController
        }
    }
    

    @IBAction func forgetPass(_ sender: Any) {
        self.performSegue(withIdentifier: "forget", sender: self)
    }
    func compayName() {
        self.ref = Database.database().reference()
        self.ref.observe(DataEventType.value, with: { (snapshot) in
            //if the reference have values
            if snapshot.childrenCount > 0 {
                //iterating through all the values
                
                for business in snapshot.children.allObjects as! [DataSnapshot] {
                    let snap = business.childSnapshot(forPath: "employees")
                    if snap.childrenCount > 0 {
                        for employee in snap.children.allObjects as! [DataSnapshot] {
                            //getting values
                            let eventsObject = employee.value as? [String: AnyObject]
                            let email1  = eventsObject?["email"] as! String
                            print(email1)
                            if self.emailField.text == email1 {
                                self.found = true
                                companyName = business.key.description
                                print(business.key.description)
                                break
                            }
                        }
                    }}
            }})
    }
}
