//
//  UserModel.swift
//  loginDemo
//
//  Created by YAUTAKWO on 13/5/2021.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var name: String {
        didSet{
            print("id:\(id) username:\(name)")
        }
    }
    var password: String{
        didSet{
            print("id:\(id) password:\(password)")
        }
    }
}
