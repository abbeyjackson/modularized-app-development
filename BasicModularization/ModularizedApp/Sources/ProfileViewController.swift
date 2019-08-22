//
//  ProfileViewController.swift
//  ModularizedApp
//
//  Created by Abbey Jackson on 2019-08-13.
//  Copyright © 2019 Abbey Jackson. All rights reserved.
//

/* <<<------- DO NOT USE THIS PROJECT FOR CODE SAMPLES ------->>>
 
 This project is part of a workspace which is used to demonstrate
 modular app development using private internal frameworks. The
 code in this project has been written ONLY to silence Xcode
 warnings and enable the framework to compile in order to interact
 with the other frameworks within the larger workspace.
 
 http://github.com/abbeyjackson/modularized-app-development/
 
 */

import UIKit

class ProfileViewController : UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var nameLabelText: String?
    var addressLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameLabelText
        addressLabel.text = addressLabelText
    }
}
