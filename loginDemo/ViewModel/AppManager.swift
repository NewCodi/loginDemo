//
//  LoginManager.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import Foundation

enum LoginState {
    case LoginState_EmptyInput
    case LoginState_NotMatch
    case LoginState_Succeed
    case LoginState_Nil
}

class AppManager: ObservableObject {
    @Published var resetOldPw:String = ""
    @Published var resetNewPw:String = ""
    @Published var resetConfPw:String = ""
    @Published var isResetPwValid:Bool = false
    
    @Published var savedUser:User?
    @Published var user:User
    @Published var banners:[Banner]
    @Published var loginState:LoginState = .LoginState_Nil {
        didSet{
            if loginState == .LoginState_Succeed {
                isLogin = true
            }
            else {
                isLogin = false
            }
        }
    }
    @Published var isLogin:Bool = false {
        didSet {
            if isLogin {
                savedUser = user
                setSaveUser()
            }
        }
    }
    
    init() {
        user = User(id: UUID(), name: "", password: "")
        banners = [
            Banner(id: UUID(), imageName: "img1"),
            Banner(id: UUID(), imageName: "img2"),
            Banner(id: UUID(), imageName: "img3"),
        ]
        getSavedUser()
    }
    
    func checkLoginInputs() {
        if user.name.isEmpty || user.password.isEmpty {
            loginState = .LoginState_EmptyInput
        }
        else {
            if let savedUser = savedUser {
                if savedUser.name==user.name && savedUser.password==user.password {
                    loginState = .LoginState_Succeed
                    print("valid input")
                }
                else{
                    loginState = .LoginState_NotMatch
                    print("input not match")
                }
            }
            else {
                loginState = .LoginState_Succeed
            }
        }
    }
    
    func checkResetInputs() -> Bool{
        isResetPwValid = !resetNewPw.isEmpty
            && !resetConfPw.isEmpty
            && resetNewPw == resetConfPw
            && savedUser?.password == resetOldPw
        
        if isResetPwValid {
            savedUser?.password = resetNewPw
            resetNewPw = ""
            resetOldPw = ""
            resetConfPw = ""
            setSaveUser()
        }
        
        return isResetPwValid
    }
    
    func logout() {
        isLogin = false
        isResetPwValid = false
        user.name = ""
        user.password = ""
        
        setSaveUser()
    }
    
    func getSavedUser() {
        // get data from keychains/userdefault
        // if already logon, let it
        // else update the saved user
    }
    
    func setSaveUser() {
        // save data to keychains/userdefualt
        // save islogin state
    }
    
    static func dummyData() -> AppManager{
        let manager = AppManager()
        manager.user = User(id: UUID(), name: "", password: "")
        manager.savedUser = User(id: UUID(), name: "Allen", password: "1234")
        manager.banners = [
            Banner(id: UUID(), imageName: "img1"),
            Banner(id: UUID(), imageName: "img2"),
            Banner(id: UUID(), imageName: "img3"),
        ]
        return manager
    }
}
