//
//  UserDataTests.swift
//  UserDataTests
//
//  Created by Abbey Jackson on 2019-08-21.
//  Copyright © 2019 Abbey Jackson. All rights reserved.
//

import XCTest
@testable import Networking
@testable import UserData

// Be aware that a developer on your team who doesn't understand proper
// testing principles, or does but doesn't grasp the importance of testing
// code in isolation may try to get data from one module in order to write
// a test and discover that by linking a module inside the "Link Binary with
// Libraries" section of the UserDataTests target and using `@testable import`
// in a test class file they can access internal methods on another module.

// This first example demonstrates accessing internal directly
class UserDataTests: XCTestCase {
    func testAccessingNetworkingInternals() {
        let networking = Networking()
        XCTAssertEqual("billybob1982", networking.userId)
    }
}

// This next example demonstrates the mess that one can get into attemping to use
// classes from other modules rather than just creating mocked data.
// NOTHING ABOUT THE EXAMPLE BELOW SHOULD BE REPRODUCED IN A REAL PROJECT... this
// is absolutely not the way to create mocked data.
@testable import Persistence

class MockDatabase: Database {
    override var objects: [String: DataObject] {
        guard let dataObject = getTestUserDataObject() else { return [:] }
        return [userId: dataObject]
    }
    
    var userFirstName = "Test"
    var userLastName = "User"
    var userId = "test user"
    
    func getTestUserDataObject() -> DataObject? {
        var mockUserResponseData = UserResponseData(
            profile: ["email": "test@test.com" as AnyObject,
                      "firstName": userFirstName as AnyObject,
                      "lastName": userLastName as AnyObject],
            location: ["address": "123 Test Street" as AnyObject,
                       "city": "Test City" as AnyObject,
                       "country": "Test Country" as AnyObject],
            lastUpdatedTime: Date().timeIntervalSince1970
        )
        mockUserResponseData.dataDictionary["authentication"] = [
            "token": "test token" as AnyObject,
            "userId": userId as AnyObject] as AnyObject
        
        guard let mockUserData = try? JSONSerialization.data(withJSONObject: mockUserResponseData.dataDictionary, options: .prettyPrinted) else { return nil }
        
        let decoder = JSONDecoder()
        guard let mockUser = try? decoder.decode(User.self, from: mockUserData) else { return nil }
        return DataObject(objectId: "testUser", objectData: mockUser.objectData)
    }
    
    func setUser(firstName: String, lastName: String) {
        userFirstName = firstName
        userLastName = lastName
    }
}

extension UserDataTests {
    func testTestUser() {
        let mockDatabase = MockDatabase()
        mockDatabase.setUser(firstName: "New First", lastName: "New Last")
        let mockUserData = mockDatabase.objects["test user"]
        
        let decoder = JSONDecoder()
        let mockUser = try! decoder.decode(User.self, from: mockUserData!.objectData!)
        
        XCTAssertNotEqual(mockUser.profile!.firstName, "Test")
    }
}

// FYI you can not testable import an app target only modules so in order
// to demonstrate this I had to copy this extension from the app itself.
extension User: DataObjectProtocol {
    public var objectId: String {
        return authentication.userId
    }
    
    public var objectData: Data? {
        return createObjectData()
    }
    
    private func createObjectData() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
