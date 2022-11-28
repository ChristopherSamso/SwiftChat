//
//  Message.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let read: String
    let text: String
    let timeStamp: Timestamp
    var user: User?
    var imageUrl: String?
}
