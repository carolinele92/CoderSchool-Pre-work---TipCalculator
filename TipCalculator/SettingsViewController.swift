//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Caroline Le on 2/1/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
   
    @IBOutlet weak var themeDetail: UILabel!
    @IBOutlet weak var roundUpTipSwitch: UISwitch!
    @IBOutlet weak var roundUpTotalSwitch: UISwitch!
    
    var seletedTheme = UIImageView()
    

    

    @IBAction func tipTotalSwitchTapped(_ sender: Any) {
        UserDefaults.standard.set(roundUpTipSwitch.isOn, forKey: "roundUpTipTotal")
    }
    
    
    @IBAction func grandTotalSwitchTapped(_ sender: Any) {
        UserDefaults.standard.set(roundUpTotalSwitch.isOn, forKey: "roundUpGrandTotal")
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if let theme = UserDefaults.standard.object(forKey: "theme") as? String {
            themeDetail.text = theme
        } else {
            let theme = "Mermaid"
            UserDefaults.standard.set(theme, forKey: "theme")
        }
        
    
     
        // --- Load switchs'state as Bool from UserDefault once screen is reloaded
        roundUpTotalSwitch.isOn = UserDefaults.standard.bool(forKey: "roundUpGrandTotal")
        roundUpTipSwitch.isOn = UserDefaults.standard.bool(forKey: "roundUpTipTotal")

    }

}
