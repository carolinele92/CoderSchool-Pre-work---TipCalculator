//
//  AboutUsVC.swift
//  TipCalculator
//
//  Created by Caroline Le on 2/7/17.
//  Copyright © 2017 The UNIQ. All rights reserved.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var themeImageView: UIImageView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let theme = UserDefaults.standard.object(forKey: "theme") as? String {
            themeImageView.image = UIImage(named: theme)
           
        }

    }

}
