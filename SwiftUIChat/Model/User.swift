//
//  User.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/26/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    var fullname: String
    let email: String
    var profileImageUrl: String
    var status: UserStatus
    var fcmToken: String?
    
    // Before Decodable came out
//    init(_ dictionary: [String : Any]) {
//        self.username = dictionary["username"] as? String ?? ""
//        self.fullname = dictionary["fullname"] as? String ?? ""
//        self.email = dictionary["email"] as? String ?? ""
//        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
//    }
}

//let MOCK_USER = User(id: "1", username: "GOOGLE", fullname: "GooGLE", email: "google@googs.com", profileImageUrl: "www.google.com")
