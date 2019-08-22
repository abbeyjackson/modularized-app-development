//
//  Location.swift
//  UserData
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

import Foundation

public struct Location: Codable {
    public var address: String
    public var city: String
    public var country: String
    
    public init(address: String, city: String, country: String) {
        self.address = address
        self.city = city
        self.country = country
    }
}
