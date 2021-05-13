//
//  ContentView.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var manager:AppManager
    
    init(with mg:AppManager = AppManager.dummyData()) {
        manager = mg
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Text("Login Demo")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        VStack(spacing: 15) {
                            TextField("username", text: $manager.user.name)
                                .frame(height: 10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                                .padding([.leading, .trailing])
                            
                            SecureField("password", text: $manager.user.password)
                                .frame(height: 10)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                                .padding([.leading, .trailing])
                        }
                        .padding(.bottom, 10)
                        
                        Button(action: {
                            manager.checkLoginInputs()
                        }, label: {
                            Text("Login")
                                .font(.title)
                                .frame(width: 150, height: 50)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.black))
                        })
                        
                    }
                    Spacer()
                    ForEach(manager.banners){ banner in
                        Image(banner.imageName)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .moveDisabled(true)
                    }
                }
                
                VStack {
                    switch(manager.loginState){
                    case .LoginState_EmptyInput:
                        Text("Username/Password Empty!")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .offset(y: 55)
                        
                    case .LoginState_NotMatch:
                        Text("Username/Password Incorrect!")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .offset(y: 55)
                    default:
                        Text("")
                    }
                    Spacer()
                }
                
                NavigationLink(
                    "", destination: ResetView(with: self.manager),
                    isActive:$manager.isLogin)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
