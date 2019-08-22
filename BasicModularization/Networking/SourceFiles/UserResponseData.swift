//
//  UserResponseData.swift
//  Networking
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

// this struct is only to create fake data. Your networking would simply
// get data from a request and return it to the caller. 
public struct UserResponseData : ResponseData {
    public var dataDictionary: [String : AnyObject] // var to demonstrate something in UserDataTests
    
    internal init(profile: [String: AnyObject], location: [String: AnyObject], lastUpdatedTime: TimeInterval) {
        self.dataDictionary = [UserDataConstants.profile.rawValue: profile as AnyObject,
                               UserDataConstants.location.rawValue: location as AnyObject,
                               UserDataConstants.lastUpdatedTime.rawValue: lastUpdatedTime as AnyObject] as [String : AnyObject]
    }
}
