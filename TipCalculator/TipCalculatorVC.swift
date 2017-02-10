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
        
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        //UserDefaults.standard.synchronize()
   
    }


    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }

 
// --- Limit textField input length
    
    func textField (_ billTextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = billTextField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
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
      
        
        // --- Setup Locale Currency
        
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
        tipCurrencyLabel.text = formatter.currencyCode
        totalCurrencyLabel.text = formatter.currencyCode
        
    
    }
    
    
    @IBAction func calculateTip() {
        
// --- Calculation formula
        
        tipPercentageValues = [Double](tipPercentage.values).sorted{$0 < $1}
        
        bill = Double(billTextField.text!) ?? 0
        
        
        
        if peopleTextField.text == "0" {
            peopleTextField.text = "1"
            people = 1.0
        } else {
            people = Double(peopleTextField.text!) ?? 1
        }
        
        
        
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
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
       
    }
    
    
    
// --- Shake to clear
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        billTextField.text = ""
        tip = 0.0
        total = 0.0
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
    }
    
}
    


