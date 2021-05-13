//
//  DataManager.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import Foundation
import SwiftKeychainWrapper

class DataManager{
    static let singleton = DataManager()
    
    private init() {
        //class need it
    }
    
    func resetAllData() {
        KeychainWrapper.standard.removeObject(forKey: Constants.keyStrings.userName)
        KeychainWrapper.standard.removeObject(forKey: Constants.keyStrings.password)
    }
    
    func saveUserData(user:User, loginState ls:Bool){
        KeychainWrapper.standard.set(user.name, forKey: Constants.keyStrings.userName)
        KeychainWrapper.standard.set(user.password, forKey: Constants.keyStrings.password)
        UserDefaults().setIsLoggedIn(value: ls)
        
        if let user = getUserData(){
            print("saved \(user)")
        }
        else {
            print("saved fail")
        }
    }
    
    func getUserData() -> User? {
        var user = User(id: UUID(), name: "", password: "")
        
        if let name = KeychainWrapper.standard.string(forKey: Constants.keyStrings.userName){
            user.name = name
        }
        else {
            return nil
        }
        
        if let pw = KeychainWrapper.standard.string(forKey: Constants.keyStrings.password){
            user.password = pw
        }else {
            return nil
        }
        
        if user.name.isEmpty || user.password.isEmpty {
            resetAllData()
            return nil
        }
        
        print("user from keyChain \(user)")
        return user
    }
    
    func getUserLoginStatus() -> Bool {
        return UserDefaults().isLoggedIn()
    }
}
