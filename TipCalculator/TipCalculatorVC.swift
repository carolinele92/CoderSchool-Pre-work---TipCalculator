//
//  TipCalculatorVC.swift
//  TipCalculator
//
//  Created by Caroline Le on 30/1/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class TipCalculatorVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipCurrencyLabel: UILabel!
    @IBOutlet weak var totalCurrencyLabel: UILabel!
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    let formatter = NumberFormatter()
    
    var tipPercentage: [String: Double]!
    var tipPercentageValues: [Double]!
    
    
    var bill: Double = 0.0
    var people: Double = 0.0
    var currency: String!
    var theme: String!
    var tip: Double = 0.0
    var total: Double = 0.0
    var roundUpGrand = false
    var roundUpTip = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// --- Initial values
        
        peopleTextField.text = "1"
        billTextField.becomeFirstResponder()
        
        
// --- Setup Locale Currency
        
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        
// --- Reset UserDefaults
        
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
  
        
        
// --- Animation
        infoLabel.center.x = view.center.x
        infoLabel.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 0.5, delay: 6, animations: {
            
            self.infoLabel.center.x += self.view.bounds.width})
   
    }




 
// --- Limit Bill textField input length
    func textField (_ billTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxBillLength = 10
        let currentBillString: NSString = billTextField.text! as NSString
        let newBillString: NSString = currentBillString.replacingCharacters(in: range, with: string) as NSString
        return newBillString.length <= maxBillLength
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
// --- Setup/Retrieve Tip %
        if let tipPercentage = UserDefaults.standard.object(forKey: "tipPercentage") as? [String: Double] {
            self.tipPercentage = tipPercentage
        
            calculateTip()
        } else {
            tipPercentage = ["bad": 10.0, "average": 15, "excellent": 20]
            
            tipPercentageValues = [Double](tipPercentage.values).sorted{$0 < $1}
            tipPercentageLabel.text = String(tipPercentageValues[0])
            
            UserDefaults.standard.set(tipPercentage, forKey: "tipPercentage")
        }
      
        print(tipPercentage)
        
        
        
// --- Retrieve user's input
        if let bill = UserDefaults.standard.object(forKey: "bill") {
            self.billTextField.text = bill as? String
            calculateTip()
        }
        
        
        if let people = UserDefaults.standard.object(forKey: "people") {
            self.peopleTextField.text = people as? String
            calculateTip()
        } else {
            peopleTextField.text = "1"
            UserDefaults.standard.set("1", forKey: "people")
            
        }
        
        
// --- Setup/Retrieve Theme
        if let theme = UserDefaults.standard.object(forKey: "theme") as? String {
            self.theme = theme
            themeImageView.image = UIImage(named: theme)
        } else {
            theme = "Mermaid"
            UserDefaults.standard.set(theme, forKey: "theme")
        }
        
        
        
// --- Setup/Retrieve round Up Switch state
        if let roundUpGrand = UserDefaults.standard.object(forKey: "roundUpGrandTotal") as? Bool {
            self.roundUpGrand = roundUpGrand
            calculateTip()
        } else {
            roundUpGrand = false
            UserDefaults.standard.set(roundUpGrand, forKey: "roundUpGrandTotal")
        }
        
        
        if let roundUpTip = UserDefaults.standard.object(forKey: "roundUpTipTotal") as? Bool {
            self.roundUpTip = roundUpTip
            calculateTip()
        } else {
            roundUpTip = false
            UserDefaults.standard.set(roundUpTip, forKey: "roundUpGrandTip")
        }
      
        formattCurrency()
        
    }
    
    
// --- Set Locale Currency
    
    func formattCurrency () {
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
        tipCurrencyLabel.text = formatter.currencyCode
        totalCurrencyLabel.text = formatter.currencyCode
    }
    
    
    
    @IBAction func calculateTip() {
        
        tipPercentageValues = [Double](tipPercentage.values).sorted{$0 < $1}
        
        bill = Double(billTextField.text!) ?? 0
        
        
// --- People textField valiation
        if peopleTextField.text == "0" {
            peopleTextField.text = "1"
            people = 1.0
        } else {
            people = Double(peopleTextField.text!) ?? 1
        }
        
        
        
// --- Calculation formula
        if tipPercentageValues.count == tipControl.numberOfSegments {
            tip = (bill * (tipPercentageValues[tipControl.selectedSegmentIndex]) / people) / 100
        } else {
            tip = bill / people / 100
        }
        
        total = (bill + tip) / (people)
        
  
        
// --- Round Up Tip & Grand Total
        if roundUpGrand {
            total = ceil(total)
        }
        
        if roundUpTip {
            tip = ceil(tip)
        }
        
        tipPercentageLabel.text = String(tipPercentageValues[tipControl.selectedSegmentIndex])
        formattCurrency()
       
    }
    
    
    
// --- Save user's input
    @IBAction func calculationFinished(_ sender: Any) {
        

        if let bill = billTextField.text  {
            UserDefaults.standard.set(bill, forKey: "bill")
        }
        
        if let people = peopleTextField.text {
            UserDefaults.standard.set(people, forKey: "people")
        }
        
    }
    
    
    
// --- Shake to clear
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        billTextField.text = ""
        peopleTextField.text = "1"
        tip = 0.0
        total = 0.0
        formattCurrency()
        UserDefaults.standard.set("", forKey: "bill")
    }
    
    
    
// --- Keyboard exit
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
}
    


