//
//  TipPercentageVC.swift
//  TipCalculator
//
//  Created by Caroline Le on 2/6/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class TipPercentageVC: UIViewController {

    @IBOutlet weak var badServiceLabel: UITextField!
    @IBOutlet weak var averageServiceLabel: UITextField!
    @IBOutlet weak var excellentServiceLabel: UITextField!    
    @IBOutlet weak var badServiceTextField: UITextField!
    @IBOutlet weak var averageServiceTextField: UITextField!
    @IBOutlet weak var excellentServiceTextField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var themeImageView: UIImageView!
    var bad: Double!
    var average: Double!
    var excellent: Double!
    
    var tipPercentage = [String: Double]()

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
// --- Create Save bar button
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped(_:)))
    }


    func saveTapped(_ sender: Any) {
        
        
        // --- Tips % are either taken from user's new input or from UserDefault
        if let badService = badServiceLabel.text {
            let tip = Double(badService) ?? tipPercentage ["bad"]
            self.bad = tip
            tipPercentage ["bad"] = bad
            
        }
        
        if let averageService = averageServiceLabel.text {
            let tip = Double(averageService) ?? tipPercentage["average"]
            self.average = tip
            tipPercentage ["average"] = average
            
        }
        
        if let excellentService = excellentServiceLabel.text {
            let tip = Double(excellentService) ?? tipPercentage["excellent"]
            self.excellent = tip
            tipPercentage ["excellent"] = excellent
            
        }
        
        
        if bad > average || bad > excellent {
            messageLabel.text = "Average / Excellent service deserves more Tip!"
            
        } else if average > excellent {
            messageLabel.text = "Excellent service deserves more Tip!"
            
        } else {
            // --- Save new Tip % in UserDefault
            UserDefaults.standard.set(tipPercentage, forKey: "tipPercentage")
            _ = navigationController?.popViewController(animated: true)
        }
        
        print(tipPercentage)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
// --- Retrieve & display new Tip % in placeholders
        
        if let theme = UserDefaults.standard.object(forKey: "theme") as? String {
            themeImageView.image = UIImage(named: theme)
        } else {
            let theme = "Mermaid"
            UserDefaults.standard.set(theme, forKey: "theme")
        }
       
        
// --- Setup/Retrieve Tip %
        
        if let tipPercentage = UserDefaults.standard.object(forKey: "tipPercentage") as? [String: Double] {
            self.tipPercentage = tipPercentage
            
            // --- Placeholders Properties
            badServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tipPercentage["bad"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])
            
            averageServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tipPercentage["average"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])
            
            excellentServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tipPercentage["excellent"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])
            
        } else {
            tipPercentage = ["bad": 10.0, "average": 15, "excellent": 20]
            UserDefaults.standard.set(tipPercentage, forKey: "tipPercentage")
        }
       
    }

   
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
       
    }
    
}
