//
//  MessageViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/28/22.
//

import Foundation

struct MessageViewModel {
    
    let message: Message
    
    init(_ message: Message) {
        self.message = message
    }
    
    var isImageMessage: Bool { return message.imageUrl != nil }
    
    var currentUid: String {
        return AuthViewModel.shared.userSession?.uid ?? " "
    }
    
    var isFromCurrentUser: Bool {
        return message.fromId == currentUid
    }
    
    var profileImageUrl: URL? {
        guard let profileImage = message.user?.profileImageUrl else { return nil }
        return URL(string: profileImage)
    }
    
    var messageImageUrl: URL? {
        guard let imageUrl = message.imageUrl else { return nil }
        return URL(string: imageUrl)
    }
    
}
