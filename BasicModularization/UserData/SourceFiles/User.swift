//
//  User.swift
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

public struct User: Codable {
    public var profile: Profile?
    public var location: Location?
    public var lastUpdatedTime: TimeInterval?
    public let authentication: Authentication
    
    public init(authentication: Authentication, profile: Profile, location: Location, lastUpdatedTime: TimeInterval) {
        self.authentication = authentication
        self.profile = profile
        self.location = location
        self.lastUpdatedTime = lastUpdatedTime
    }
    
    public mutating func updateName(to newName: String) {
        if let profile = self.profile {
            let newProfile = Profile(firstName: newName, lastName: profile.lastName, email: profile.email)
            self.profile = newProfile
        }
        
        self.lastUpdatedTime = Date().timeIntervalSince1970
    }
}
