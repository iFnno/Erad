//
//  LoginViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController:UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        //empty field
        if emailField.text == "" || passwordField.text == "" {
            self.createAlert(title:"خطأ", message: "الرجاء كتابة البريد الالكتروني وكلمة المرور")}
        else{
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                if error == nil {self.performSegue(withIdentifier: "loginSegue", sender: self)
                    print("You have successfully logged in")}
                else { self.createAlert(title: "خطأ", message: "الرجاء التأكد من صحة البريد الاكتروني و كلمة المرور")}
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
