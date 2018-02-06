//
//  SplitViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/5/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SplitViewController: UISplitViewController {

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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
