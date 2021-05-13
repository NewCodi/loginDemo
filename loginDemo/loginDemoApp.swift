//
//  loginDemoApp.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import SwiftUI

@main
struct loginDemoApp: App {
    @StateObject var mainManager = AppManager()
    var body: some Scene {
        WindowGroup {
            LoginView(with: mainManager)
        }
    }
}
