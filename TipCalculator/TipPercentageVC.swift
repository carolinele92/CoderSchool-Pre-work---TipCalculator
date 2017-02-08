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
    
    @IBOutlet weak var themeImageView: UIImageView!
   
    
    var tipPercentage = [String: Double]()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
// --- Create Save bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped(_:)))
    
    
// --- Setup/Retrieve Tip %
        
        if let tipPercentage = UserDefaults.standard.object(forKey: "tipPercentage") as? [String: Double] {
            self.tipPercentage = tipPercentage
        } else {
            tipPercentage = ["bad": 10.0, "average": 15, "excellent": 20]
            UserDefaults.standard.set(tipPercentage, forKey: "tipPercentage")
        }
        
        
    }

    func saveTapped(_ sender: Any) {
        
        
        // --- Tips % are either taken from user's new input or from UserDefault
        if let badService = badServiceLabel.text {
            let tip = Double(badService) ?? tipPercentage ["bad"]
            tipPercentage ["bad"] = tip
            
        }
        
        if let averageService = averageServiceLabel.text {
            let tip = Double(averageService)
            tipPercentage ["average"] = tip ?? tipPercentage["average"]
            
        }
        
        if let excellentService = excellentServiceLabel.text {
            let tip = Double(excellentService) ?? tipPercentage["excellent"]
            tipPercentage ["excellent"] = tip
            
        }
        
        
        // --- Save new Tip % in UserDefault
        UserDefaults.standard.set(tipPercentage, forKey: "tipPercentage")
        _ = navigationController?.popViewController(animated: true)
        
        print(tipPercentage)
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
// --- Retrieve & display new Tip % in placeholders
        if let tips = UserDefaults.standard.object(forKey: "tipPercentage") as? [String: Double],
            let theme = UserDefaults.standard.object(forKey: "theme") as? String {
        
            themeImageView.image = UIImage(named: theme)
     
            
// --- Placeholders Properties
            badServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tips["bad"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])
            
            averageServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tips["average"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])
            
            excellentServiceTextField.attributedPlaceholder = NSAttributedString(string: "\(tips["excellent"]!)%", attributes: [NSForegroundColorAttributeName: UIColor.black])

        }
    }
    
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
