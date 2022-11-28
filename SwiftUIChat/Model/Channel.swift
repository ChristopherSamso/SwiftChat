//
//  Channel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/7/22.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct Channel: Identifiable, Decodable {
    @DocumentID var id: String?
    let imageUrl: String?
    let timestamp: Timestamp?
    var lastMessage: String
    let name: String
    let uids: [String]
}
