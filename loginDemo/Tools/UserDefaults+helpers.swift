//
//  UserDefaults+helpers.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import Foundation

extension UserDefaults {
    func setIsLoggedIn(value:Bool) {
        setValue(value, forKey: Constants.userDefaultStrings.isLogin)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: Constants.userDefaultStrings.isLogin)
    }
}
