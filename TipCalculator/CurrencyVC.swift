//
//  CurrencyVC.swift
//  TipCalculator
//
//  Created by Caroline Le on 2/6/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class CurrencyVC: UITableViewController {

    var currencyChosen = String()
    
    let currencyNames = [
        "Australian dollar",
        "European Euro",
        "Japanese Yen",
        "New Zealand Dollar",
        "Pound sterling",
        "Singapore Dollar",
        "South Korean Won",
        "Thai Baht",
        "United States Dollar",
        "Vietnam Dong"
    ]
    
    let currencyAbbs = [
        "AUD",
        "EUR",
        "JPY",
        "NZD",
        "GBP",
        "SGD",
        "KRW",
        "THB",
        "USD",
        "VND"
    ]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        
        cell.textLabel?.text = currencyNames[indexPath.row]
        cell.detailTextLabel?.text = currencyAbbs[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currencyChosen = currencyAbbs[indexPath.row]
        
        UserDefaults.standard.set(currencyChosen, forKey: "currency")
        _ = navigationController?.popViewController(animated: true)
    }

}





