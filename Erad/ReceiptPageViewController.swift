//
//  ReceiptPageViewController.swift
//  إيراد
//
//  Created by Afnan S on 2/28/18.
//  Copyright © 2018 KSU. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import MessageUI
import WebKit


class ReceiptPageViewController: UIViewController, MFMailComposeViewControllerDelegate {
    

    @IBOutlet weak var webView: WKWebView!
    
    
    
    var ref : DatabaseReference!
    var amount : Double! = 0.0
    var RemainingAmount : Double! = 0.0
    var ReceivedAmount : Double! = 0.0
   var receiptID : Int = 0
    var HTMLString : String = "s"
    var userName : String = ""
    var userID : String = ""
    var paused = false
    var picPath : String! = ""
    var fromRefund = false
    var employeeName : String! = ""
    var refundReceipt : Receipt! = Receipt(id: 0, date: "", time: "", totalPrice: 0, employeeID: "", ReceivedAmount: 0, RemainingAmount: 0, refundEmployeeID: "")
    var RefundList : [ShoppingCardItem] = []
    var DeleteReceitKey : String! = ""
    var fromReceiptsPage = false
    
    var shoppingCard : [ShoppingCardItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = (Auth.auth().currentUser?.uid.description)!
        ref = Database.database().reference().child(companyName)
        self.ref.child("employees").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let fname = snapshot.childSnapshot(forPath: "firstName").value as! String
            let lname = snapshot.childSnapshot(forPath: "lastName").value as! String
            self.employeeName = fname + " " + lname
        })
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateToAppend = String(formatter.string(from: date))
        formatter.dateFormat = "HH:mm"
        let timeToAppend = String(formatter.string(from: date))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            if self.fromRefund == false {

        self.HTMLString = "<html><style type='text/css'>html,body {text-align: center;}, table {align: center; text-align: center;} </style><body>"
        self.ref.child("manager").observeSingleEvent(of: .value, with: { (snapshot) in
            self.picPath = snapshot.childSnapshot(forPath: "picPath").value as! String
        })
        
        
        self.HTMLString = self.HTMLString + "<img src=" + self.picPath + "><br>"
        
        
        
        
         self.HTMLString = self.HTMLString + "<h1>" + companyName + "</h1><h2> مرحباً بك <br> فاتورة رقم #  " + String(self.receiptID)

        self.HTMLString = self.HTMLString + "<br> الوقت"
        self.HTMLString = self.HTMLString + timeToAppend + "<br>التاريخ"
        self.HTMLString = self.HTMLString + dateToAppend + "<br>  الموظف "
        self.HTMLString = self.HTMLString + self.userName + "</h2><br><table width='880'  cellspacing='0' cellpadding='0'>"
        self.HTMLString = self.HTMLString + "<tr><th><h2> السعر </h2></th> <th><h2> الكمية </h2></th> <th><h2> اسم المنتج</h2></th></tr>"
      
        self.title = "فاتورة جديدة رقم #" + String(self.receiptID)
        
         let ch = self.ref.child("receipts").childByAutoId()
                ch.setValue(["date": dateToAppend,"employeeID": self.userID,"id":self.receiptID ,"time": timeToAppend,"totalPrice":self.amount,"products": "","RemainingAmount":self.RemainingAmount,"ReceivedAmount":self.ReceivedAmount,"employeeName":self.employeeName])
                for ind in self.shoppingCard {
                    ch.child("products").child(ind.pID).setValue(["price": ind.price,"quantity": ind.quantity,"category":ind.category,"name":ind.pname,"cost":ind.cost])
            self.HTMLString = self.HTMLString + "<tr border-bottom='1pt'><td align='center'><h3>" + String(ind.price)
            self.HTMLString = self.HTMLString + "</h3></td><td align='center'><h3>" + String(ind.quantity)
            self.HTMLString = self.HTMLString + "</h3></td><td align='center'><h3>" + ind.pname
            self.HTMLString = self.HTMLString + "</h3></td></tr>"

        // Do any additional setup after loading the view.
    }
        self.HTMLString = self.HTMLString + "<tr><td align='center'><h2>" + String(self.amount) + "</h2></td><td align='right' colspan = '2'><h3>المجموع</h3></td></tr>"
         self.HTMLString = self.HTMLString + "<tr><td align='center'><h2>" + String(self.ReceivedAmount) + "</h2></td><td align='right' colspan = '2'><h3>المبلغ المستلم</h3></td></tr>"
        
        self.HTMLString = self.HTMLString + "<tr><td align='center'><h2>" + String(self.RemainingAmount) + "</h2></td><td align='right' colspan = '2'><h3>الباقي</h3></td></tr></table></body></html>"
       
        //self.navigationItem.hidesBackButton = false
        
            self.webView.loadHTMLString(self.HTMLString , baseURL: nil) //}
            
            
            
            
        } else {

            
                self.ref.child("receipts").child(self.DeleteReceitKey).removeValue(completionBlock: { (error, refer) in
                if error != nil {
                    self.print(error)
                } else {
                    self.print(refer)
                    self.print("Child Removed Correctly")
                }
            })
            self.HTMLString = "<html><style type='text/css'>html,body {text-align: center;}, table {align: center; text-align: center;} </style><body>"
            self.ref.child("manager").observeSingleEvent(of: .value, with: { (snapshot) in
                self.picPath = snapshot.childSnapshot(forPath: "picPath").value as! String
            })
            
            
            self.HTMLString = self.HTMLString + "<img src=" + self.picPath + "><br>"
            
            
            
            
            self.HTMLString = self.HTMLString + "<h1>" + companyName + "</h1><h2> مرحباً بك <br> فاتورة رقم #  " + String(self.refundReceipt.id)
            
            self.HTMLString = self.HTMLString + "<br> الوقت"
            self.HTMLString = self.HTMLString + timeToAppend + "<br>التاريخ"
            self.HTMLString = self.HTMLString + dateToAppend + "<br>  الموظف "
            self.HTMLString = self.HTMLString + self.userName + "</h2><br><table width='880'  cellspacing='0' cellpadding='0'>"
            self.HTMLString = self.HTMLString + "<tr><th><h2> السعر </h2></th> <th><h2> الكمية </h2></th> <th><h2> اسم المنتج</h2></th></tr>"
            

            self.title = "فاتورة جديدة رقم #" + String(self.refundReceipt.id)
            
            let ch = self.ref.child("receipts").childByAutoId()
                ch.setValue(["date": dateToAppend,"employeeID": self.userID,"id":self.refundReceipt.id ,"time": timeToAppend,"totalPrice":self.refundReceipt.totalPrice ,"products": "","RemainingAmount":self.refundReceipt.RemainingAmount,"ReceivedAmount":self.refundReceipt.totalPrice, "refundEmployeeID": self.refundReceipt.refundEmployeeID,"employeeName":self.employeeName])
            for ind in self.RefundList {
                self.ref.child("products").child(ind.category).child(ind.pID).observeSingleEvent(of: .value, with: { (snapshot) in
                    let num = snapshot.childSnapshot(forPath: "inventory").value as! Int
                        let newnum = num + ind.quantity
                        let newnumString = Int(newnum)
                        self.ref.child("products").child(ind.category).child(ind.pID).updateChildValues(["inventory":newnumString])
                    })

                 ch.child("products").child(ind.pID).setValue(["price": ind.price,"quantity": ind.quantity,"category":ind.category,"name":ind.pname,"cost":ind.cost])
                self.HTMLString = self.HTMLString + "<tr border-bottom='1pt'><td align='center'><h3>" + String(ind.price)
                self.HTMLString = self.HTMLString + "</h3></td><td align='center'><h3>" + String(ind.quantity)
                self.HTMLString = self.HTMLString + "</h3></td><td align='center'><h3>" + ind.pname
                self.HTMLString = self.HTMLString + "</h3></td></tr>"
                
                // Do any additional setup after loading the view.
            }
            self.HTMLString = self.HTMLString + "<tr><td align='center'><h2>" + String(self.refundReceipt.totalPrice) + "</h2></td><td align='right' colspan = '2'><h3>المجموع</h3></td></tr>"
            self.HTMLString = self.HTMLString + "<tr><td align='center'><h2>" + String(self.refundReceipt.ReceivedAmount) + "</h2></td><td align='right' colspan = '2'><h3>المبلغ المستحق</h3></td></tr>"
            
            self.HTMLString = self.HTMLString + "<tr><td align='center'></td><td align='right' colspan = '2'></td></tr></table></body></html>"
            
            //self.navigationItem.hidesBackButton = false
            
            self.webView.loadHTMLString(self.HTMLString , baseURL: nil)
            
        }
        }
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "إنهاء", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ReceiptPageViewController.back(sender:)))
        self.navigationItem.rightBarButtonItem = newBackButton
    }
    @objc func back(sender: UIBarButtonItem) {
        if self.paused == true {
             _ = navigationController?.popToRootViewController(animated: true)
            
        } else {
            if self.fromReceiptsPage == false {
        let previousViewController = self.navigationController?.viewControllers.first as! ProductsMenuViewController
        previousViewController.shoppingCard.removeAll()
        previousViewController.currentShoppingCardButton.isHidden = true
        _ = navigationController?.popToRootViewController(animated: true)
        }  else {
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
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
        var printController = UIPrintInteractionController.shared
        printController.printFormatter = self.wkWebViewPrintFormatter()
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
            let wkPDFData = ReceiptPageViewController.generate(using: self.wkWebViewPrintFormatter())
            composeVC.addAttachmentData( wkPDFData, mimeType: "application/pdf", fileName: "Receipt.pdf")
            composeVC.setSubject(ss)
            composeVC.setMessageBody(self.HTMLString, isHTML: true)
            
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
    
    
    class func generate(using printFormatter: UIPrintFormatter) -> Data {
        
        // assign the print formatter to the print page renderer
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        // assign paperRect and printableRect values
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        renderer.setValue(page, forKey: "paperRect")
        renderer.setValue(page, forKey: "printableRect")
        
        // create pdf context and draw each page
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 0..<renderer.numberOfPages {
            UIGraphicsBeginPDFPage()
            renderer.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        
        UIGraphicsEndPDFContext();
        
        // save data to a pdf file and return
        guard nil != (try? pdfData.write(to: outputURL, options: .atomic))
            else { fatalError("Error writing PDF data to file.") }
        
        return pdfData as Data
    }
    private class var outputURL: URL {
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            else { fatalError("Error getting user's document directory.") }
        
        let url = directory.appendingPathComponent(outputFileName).appendingPathExtension("pdf")
        Swift.print("open \(url.path)")
        return url
    }
    
    private class var outputFileName: String {
        return "generated-\(Int(Date().timeIntervalSince1970))"
    }
    private func wkWebViewPrintFormatter() -> UIPrintFormatter {
        return webView.viewPrintFormatter()
    }
    private func loadIntoWKWebView(_ data: Data) {
        webView.load(data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: Bundle.main.bundleURL)
    }
}

