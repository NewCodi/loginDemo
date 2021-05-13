//
//  MainView.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var manager:AppManager
    
    init(with mg:AppManager = AppManager.dummyData()) {
        self.manager = mg
    }
    
    var body: some View {
        VStack {
            Spacer()
            if let name = manager.savedUser?.name {
                Group {
                    Text("Login Successful!")
                        .font(.largeTitle)
                    Text("Welcome \(name)!")
                        .font(.title2)
                        .offset(y:25)
                }
                .foregroundColor(.red)
            }
            Spacer()
            Button(action: {
                self.manager.logout()
                LoginView(with: self.manager)
            }, label: {
                Text("Logout")
                    .font(.title)
                    .frame(width: 150, height: 50)
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.black))
            })
            Spacer()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
