//
//  ReceiptPageViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/28/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import MessageUI


class ReceiptPageViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    
    
    var ref : DatabaseReference!
    var ref1 : DatabaseReference!
    var amount : Double! = 0.0
    var RemainingAmount : Double! = 0.0
    var ReceivedAmount : Double! = 0.0
    var receiptID : Int = 0
    var HTMLString : String = ""
    var userName : String = ""
    var userID : String = ""
    
    @IBOutlet weak var Remaining: UILabel!
    var shoppingCard : [ShoppingCardItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "فاتورة جديدة رقم #" + String(self.receiptID)
        print("find id here")
        self.Remaining.text = String(self.RemainingAmount)
        userID = (Auth.auth().currentUser?.uid.description)!
        print(userID)
    /*    self.ref1 = Database.database().reference().child("employees")
        ref1.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let firstname = value?["firstName"] as! String
            let lastname = value?["lastName"] as! String
            self.userName = firstname + lastname
        }) */

        self.ref = Database.database().reference()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateToAppend = String(formatter.string(from: date))
        formatter.dateFormat = "HH:mm"
        let timeToAppend = String(formatter.string(from: date))
        self.HTMLString = "<html><body>Erad <br> مرحباً بك <br> فاتورة رقم #" + String(self.receiptID)
        //<img src=https://firebasestorage.googleapis.com/v0/b/erad-system.appspot.com/o/Screen%20Shot%202018-02-27%20at%209.15.35%20AM.png?alt=media&token=14e08dd1-fa5d-4078-a93c-45e6c3990f24><br>
        self.HTMLString = self.HTMLString + "<br> الوقت"
        self.HTMLString = self.HTMLString + timeToAppend + "<br>  التاريخ"
        self.HTMLString = self.HTMLString + dateToAppend + "<br> الموظف " + self.userName + "<br></body></html>"
        
        
        self.ref = Database.database().reference()
        let ch = self.ref.child("receipts").childByAutoId()
        
        ch.setValue(["date": dateToAppend,"employeeID": userID,"id":self.receiptID ,"time": timeToAppend,"totalPrice":self.amount,"products": "","RemainingAmount":self.RemainingAmount,"ReceivedAmount":self.ReceivedAmount])
        for ind in shoppingCard {
            ch.child("products").child(ind.pname).setValue(["price": ind.price,"quantity": ind.quantity])

        // Do any additional setup after loading the view.
    }
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "رجوع", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ReceiptPageViewController.back(sender:)))
        self.navigationItem.rightBarButtonItem = newBackButton
        self.navigationItem.hidesBackButton = false

       /* weak var weakSelf = self
        
        // Assign back button with back arrow and text (exactly like default back button)
        navigationItem.leftBarButtonItems = CustomBackButton.createWithText(text: "رجوع", color: UIColor.blue, target: weakSelf, action: #selector(ReceiptPageViewController.tappedBackButton)) */
        
        self.webView.loadHTMLString(self.HTMLString , baseURL: nil)
    }
    @objc func back(sender: UIBarButtonItem) {
        let previousViewController = self.navigationController?.viewControllers.first as! ProductsMenuViewController
        previousViewController.shoppingCard.removeAll()
        previousViewController.currentShoppingCardButton.isHidden = true
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    @objc func tappedBackButton() {
        
        let previousViewController = self.navigationController?.viewControllers.first as! ProductsMenuViewController
        previousViewController.shoppingCard.removeAll()
        previousViewController.currentShoppingCardButton.isHidden = true
        _ = navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func print(_ sender: Any) {
        

        var pInfo :UIPrintInfo = UIPrintInfo.printInfo()
        pInfo.outputType = UIPrintInfoOutputType.general
        pInfo.jobName = (webView.request?.url?.absoluteString)!
        pInfo.orientation = UIPrintInfoOrientation.portrait
        
        var printController = UIPrintInteractionController.shared
        printController.printInfo = pInfo
        printController.showsPageRange = true
        printController.printFormatter = webView.viewPrintFormatter()
        printController.present(animated: true, completionHandler: nil)

    }
    
    
    @IBAction func sendEmailButton(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "البريد الإلكتروني", message: "ادخل البريد الإلكتروني الخاص بالعميل", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            let email = textField?.text
            composeVC.setToRecipients([email!])
            let ss = "فاتورة"
            composeVC.setSubject(ss)
            composeVC.setMessageBody("<html><body>Hello world</body></html>", isHTML: true)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)

        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
        
      
        
        
        
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            break
        case .failed:
            break
            
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
   
}

