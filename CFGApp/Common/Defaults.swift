//
//  Defaults.swift
//  CFGApp
//
//  Created by Sakshi on 27/12/24.
//

import Foundation
import UIKit

class Defaults {
    static var accessToken: String? {
        get {
            return UserDefaults.standard.object(forKey: "accessToken") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var refreshToken: String? {
        get {
            return UserDefaults.standard.object(forKey: "Refresh_Token") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Refresh_Token")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var instanceUrl: String? {
        get {
            return UserDefaults.standard.object(forKey: "Instance_Url") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Instance_Url")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userId: String? {
        get {
            return UserDefaults.standard.object(forKey: "UserId") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserId")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var Id: String? {
        get {
            return UserDefaults.standard.object(forKey: "Id") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Id")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var organizationToken: String? {
        get {
            return UserDefaults.standard.object(forKey: "OrganizationToken") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "OrganizationToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userRole: String? {
        get {
            return UserDefaults.standard.object(forKey: "UserRole") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserRole")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var signature: String? {
        get {
            return UserDefaults.standard.object(forKey: "Signature") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Signature")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var Access_Level__c: String? {
        get {
            return UserDefaults.standard.object(forKey: "Access_Level__c") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Access_Level__c")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var tokenType: String? {
        get {
            return UserDefaults.standard.object(forKey: "Token_Type") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Token_Type")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isFirstTimeLogin: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "LoginFirstTime") as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "LoginFirstTime")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userName: String? {
        get {
            return UserDefaults.standard.object(forKey: "UserName") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserName")
            UserDefaults.standard.synchronize()
        }
    }

    static var userEmail: String? {
        get {
            return UserDefaults.standard.object(forKey: "UserEmail") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserEmail")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userLastName: String? {
        get {
            return UserDefaults.standard.object(forKey: "userLastName") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userLastName")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userPassword: String? {
        get {
            return UserDefaults.standard.object(forKey: "UserPassword") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserPassword")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userFirstName: String? {
        get {
            return UserDefaults.standard.object(forKey: "userFirstName") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userFirstName")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userMobileNumber: String? {
        get {
            return UserDefaults.standard.object(forKey: "userMobileNumber") as? String ?? EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userMobileNumber")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isUserLoggedIn: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "IsUserLoggedIn") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "IsUserLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userImage: UIImage? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "UserProfileImage") else { return UIImage(named: "HomeProfileIcon") }
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image
        }
        set {
            guard let data = newValue?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: "UserProfileImage")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func removeUserImage() {
        UserDefaults.standard.removeObject(forKey: "UserProfileImage")
        UserDefaults.standard.synchronize()
    }
 
    static var APNSTokenSave: String? {
        get {
            if let previousAppVersion = UserDefaults.standard.object(forKey: "apnstoken") as? String {
                return previousAppVersion
            }
            return EMPTY
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "apnstoken")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isCalenderSync: Bool? {
        get {
            return UserDefaults.standard.object(forKey: "CalenderSync") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CalenderSync")
            UserDefaults.standard.synchronize()
        }
    }
}


