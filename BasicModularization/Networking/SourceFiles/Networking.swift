//
//  Networking.swift
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

public struct Networking {
    
    // these would normally come from actual networking
    let token = "dj912iwefj2o2nf2rmf09234mf2"
    let userId = "billybob1982"
    
    public init() { }
    
    public func makeRequest(type: RequestType, requestData: [String: AnyObject]? = nil, completion: (NetworkingError?, ResponseData?) -> ())  {
        
        // does networking stuff
        
        // this part here is only to create fake data. Your networking would simply
        // get data from a request and return it to the caller
        switch type {
        case .authentication:
            completion(nil, authenticationResponse())
        case .getUserData:
            completion(nil, getUserResponse())
        case .updateUser:
            break
        }
    }
    
    func authenticationResponse() -> AuthenticationResponseData? {
        
        return AuthenticationResponseData(userID: userId, token: token)
    }
    
    func getUserResponse() -> UserResponseData? {
        
        let profileDictionary: [String: AnyObject] = [
            "firstName": "Daffy" as AnyObject,
            "lastName": "Duck" as AnyObject,
            "email": "billy@bob.com" as AnyObject
        ]
        let locationDictionary: [String: AnyObject] = [
            "address": "123 Smith Street" as AnyObject,
            "city": "Toronto" as AnyObject,
            "country": "Canada" as AnyObject
        ]
        let lastUpdatedTime = Date().timeIntervalSince1970
        
        return UserResponseData(profile: profileDictionary, location: locationDictionary, lastUpdatedTime: lastUpdatedTime)
    }
}
