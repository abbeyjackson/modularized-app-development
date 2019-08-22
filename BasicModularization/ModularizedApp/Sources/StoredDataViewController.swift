//
//  SettingsViewController.swift
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

class StoredDataViewController : UIViewController {
    
    @IBOutlet weak var localUserLabel: UILabel!
    @IBOutlet weak var localUserLastUpdatedLabel: UILabel!
    @IBOutlet weak var storedUserLabel: UILabel!
    @IBOutlet weak var storedLastUpdatedLabel: UILabel!
    
    var localUserLabelText: String?
    var localUserLastUpdatedText: String?
    var storedUserLabelText: String?
    var storedLastUpdatedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localUserLabel.text = localUserLabelText
        localUserLastUpdatedLabel.text = localUserLastUpdatedText
        storedUserLabel.text = storedUserLabelText
        storedLastUpdatedLabel.text = storedLastUpdatedText
    }
}
