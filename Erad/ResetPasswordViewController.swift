//
//  ResetPasswordViewController.swift
//  إيراد
//
//  Created by Raghad Almojil on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        if self.emailField.text == "" {//
            let alertController = UIAlertController(title: "خطأ", message: "الرجاء كتابة البريد الإلكتروني", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "حسنا", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            Auth.auth().sendPasswordReset(withEmail: self.emailField.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "خطأ"
                    message = (error?.localizedDescription)!
                } else {
                    title = "شكرا"
                    message = "تم ارسال بريد إعادة تعيين كلمة المرور الى البريد الإلكتروني الخاص بك"
                    self.emailField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "حسنا", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
        
    }
    
    @IBAction func goLoginPage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "login", sender: self)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            _ = segue.destination as! LoginViewController
        }
        //do the other segue prep
    }
    

    
}

