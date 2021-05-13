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
    
    @Published var savedUser:User?
    @Published var user:User
    @Published var banners:[Banner]
    @Published var loginState:LoginState = .LoginState_Nil {
        didSet{
            if loginState == .LoginState_Succeed {
                savedUser = user
                setSaveUser()
                isLogin = true
            }
            else {
                isLogin = false
            }
        }
    }
    @Published var isLogin:Bool = false
    
    init() {
        user = User(id: UUID(), name: "", password: "")
        banners = [
            Banner(id: UUID(), imageName: "img1"),
            Banner(id: UUID(), imageName: "img2"),
            Banner(id: UUID(), imageName: "img3"),
        ]
        syncSavedData()
    }
    
    func checkLoginInputs() {
        if user.name.isEmpty || user.password.isEmpty {
            loginState = .LoginState_EmptyInput
        }
        else {
            if let savedUser = savedUser {
                if savedUser.name==user.name && savedUser.password==user.password {
                    loginState = .LoginState_Succeed
                }
                else{
                    loginState = .LoginState_NotMatch
                }
            }
            else {
                loginState = .LoginState_Succeed
            }
        }
    }
    
    func isResetInfoValid() -> Bool{
        let ret = !resetNewPw.isEmpty && !resetConfPw.isEmpty && resetNewPw == resetConfPw && savedUser?.password == resetOldPw
        if ret {
            updateUserInfo()
            cleanReset()
        }
        return ret
    }
    
    func cleanReset() {
        resetNewPw = ""
        resetOldPw = ""
        resetConfPw = ""
    }
    
    func updateUserInfo() {
        savedUser?.password = resetNewPw
        setSaveUser()
    }
    
    func syncSavedData() {
        // get data from keychains/userdefault
        // if already logon, let it
        // else update the saved user
        if let user = DataManager.singleton.getUserData(){
            savedUser = user
            isLogin = DataManager.singleton.getUserLoginStatus()
        }
    }
    
    func setSaveUser() {
        // save data to keychains/userdefualt
        // save islogin state
        if let user = savedUser {
            DataManager.singleton.saveUserData(user: user, loginState: isLogin)
        }
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
