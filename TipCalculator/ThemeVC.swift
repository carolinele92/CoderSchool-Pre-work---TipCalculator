//
//  ThemeVC.swift
//  TipCalculator
//
//  Created by Caroline Le on 2/3/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class ThemeVC: UITableViewController {

    var themeNames = ["Sunset", "Dreamer", "Mermaid"]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        // --- TextLabel - theme tableViewCell
        cell.textLabel?.text = themeNames[indexPath.row]
        cell.textLabel?.textAlignment = .center
        
        // --- Background Image - theme tableViewCell
        cell.backgroundView = UIImageView(image: UIImage(named: themeNames[indexPath.row]))
        cell.backgroundColor = UIColor.clear
    
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // --- Save selected theme in UserDefault
        let theme = themeNames[indexPath.row]
        
        UserDefaults.standard.set(theme, forKey: "theme")
        _ = navigationController?.popToRootViewController(animated: true)
    }

}





