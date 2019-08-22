//
//  WelcomeViewController.swift
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
import Persistence
import Networking
import UserData

class WelcomeViewController : UIViewController {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    lazy var database = Database()
    lazy var networking = Networking()
    
    var user: User?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        networking.makeRequest(type: .authentication) { error, responseData in
            if let error = error {
                print(error.message)
            }
            
            guard let responseData = responseData as? AuthenticationResponseData,
                let userId = responseData.dataDictionary[AuthenticationConstants.userId.rawValue] as? String,
                let token = responseData.dataDictionary[AuthenticationConstants.token.rawValue] as? String else {
                    return
            }
            
            let authentication = Authentication(userId: userId, token: token)
            
            self.getUser(from: authentication)
            guard let user = self.user else { return }
            
            let userDataObject = DataObject(objectId: user.objectId,
                                            objectData: user.objectData)
            
            database.store(userDataObject)
        }
    }
    
    func getUser(from authentication: Authentication) {
        let requestData = [AuthenticationConstants.userId.rawValue: authentication.userId as AnyObject,
                           AuthenticationConstants.token.rawValue: authentication.token as AnyObject]
        
        networking.makeRequest(type: .getUserData, requestData: requestData, completion: { error, responseData in
            
            if let error = error {
                print(error.message)
            }
            
            guard let lastUpdatedTime = lastUpdated(responseData) else { return }
            guard let profile = createProfile(responseData) else { return }
            guard let location = createLocation(responseData) else { return }
            
            let retrievedUser = User(authentication: authentication, profile: profile, location: location, lastUpdatedTime: lastUpdatedTime)
            
            self.user = retrievedUser
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let user = user else { return }
        
        if let destination = segue.destination as? ProfileViewController {
            
            destination.nameLabelText = (user.profile?.firstName ?? "") + " " + (user.profile?.lastName ?? "")
            if destination.nameLabelText == " " {
                destination.nameLabelText = "No name loaded"
            }
            
            destination.addressLabelText = user.location?.address
        } else if let destination = segue.destination as? StoredDataViewController {
            destination.localUserLabelText = (user.profile?.firstName ?? "") + " " + (user.profile?.lastName ?? "")
            destination.localUserLastUpdatedText = String(user.lastUpdatedTime ?? 0)
            
            destination.storedUserLabelText = "No stored user"
            
            if let storedUserDataObject = database.get(user.objectId),
                let objectData = storedUserDataObject.objectData {
                
                let decoder = JSONDecoder()
                var storedUser = try? decoder.decode(User.self, from: objectData)
                
                storedUser?.updateName(to: "Donald")
                
                destination.storedUserLabelText = (storedUser?.profile?.firstName ?? "") + " " + (storedUser?.profile?.lastName ?? "")
                destination.storedLastUpdatedText = String(storedUser?.lastUpdatedTime ?? 0)
            }
        }
    }
}

extension WelcomeViewController {
    func createProfile(_ responseData: ResponseData?) -> Profile? {
        guard let responseData = responseData as? UserResponseData,
            let profileDictionary = responseData.dataDictionary[UserDataConstants.profile.rawValue] as? [String: AnyObject],
            let firstName = profileDictionary[ProfileConstants.firstName.rawValue] as? String,
            let lastName = profileDictionary[ProfileConstants.lastName.rawValue] as? String,
            let email = profileDictionary[ProfileConstants.email.rawValue] as? String
            else { return nil }
        return Profile(firstName: firstName, lastName: lastName, email: email)
    }
    
    func lastUpdated(_ responseData: ResponseData?) -> TimeInterval? {
        return responseData?.dataDictionary[UserDataConstants.lastUpdatedTime.rawValue] as? TimeInterval
    }
    
    func createLocation(_ responseData: ResponseData?) -> Location? {
        guard let responseData = responseData as? UserResponseData,
            let locationDictionary = responseData.dataDictionary[UserDataConstants.location.rawValue] as? [String: AnyObject],
            let address = locationDictionary[LocationConstants.address.rawValue] as? String,
            let city = locationDictionary[LocationConstants.city.rawValue] as? String,
            let country = locationDictionary[LocationConstants.country.rawValue] as? String
            else { return nil }
        return Location(address: address, city: city, country: country)
    }
}
