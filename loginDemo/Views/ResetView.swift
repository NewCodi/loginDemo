//
//  ResetView.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import SwiftUI

struct ResetView: View {
    @State var showAlert:Bool = false
    @ObservedObject var manager:AppManager
    
    init(with mg:AppManager = AppManager.dummyData()) {
        self.manager = mg
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 25) {
                    Spacer()
                    if let name = manager.savedUser?.name {
                        VStack {
                            Text("Welcome \(name)!")
                            Text("Please reset your password!")
                        }
                        .font(.title)
                        .foregroundColor(.blue)
                    }
                    HStack {
                        VStack(alignment: .trailing, spacing: 25) {
                            Text("Origin :")
                            Text("New :")
                            Text("Confirm :")
                        }
                        .padding(.leading, 10)
                        
                        VStack(spacing: 20) {
                            TextField("original password", text: $manager.resetOldPw)
                                .padding(.leading, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                                .padding([.leading, .trailing])
                            TextField("new password", text: $manager.resetNewPw)
                                .padding(.leading, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                                .padding([.leading, .trailing])
                            TextField("confirm password", text: $manager.resetConfPw)
                                .padding(.leading, 5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1.5)
                                )
                                .padding([.leading, .trailing])
                        }
                    }
                    
                    Button(action: {
                        self.showAlert = !self.manager.checkResetInputs()
                    }, label: {
                        Text("Confirm")
                            .font(.title)
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.black))
                    })
                    
                    NavigationLink("", destination: MainView(with: self.manager),isActive: $manager.isResetPwValid)
                    
                    Spacer()
                }
            }
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Error!"), message: Text("Invalid Input!"), dismissButton:.default(Text("OK")))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
    }
}
