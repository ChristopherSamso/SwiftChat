//
//  CreateChannelViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/4/22.
//

import Foundation
import UIKit
import Firebase

class CreateChannelViewModel: ObservableObject {
    @Published var didCreateChannel = false
    let users: [User]
    
    init(_ selectableUsers: [SelectableUser]) {
        self.users = selectableUsers.map({ $0.user })
        
        print("DEBUG: LIST OF USERS: \(self.users)")
    }
    
    func createChannel(name: String, image: UIImage?) {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        guard let currentUid = currentUser.id else { return }
        
        var uids = users.compactMap({ $0.id })
        uids.append(currentUid)
        
        var data: [String: Any] = ["name": name,
                                   "uids": uids,
                                   "lastMessage": "\(currentUser.fullname) created group \(name)",
                                   "timestamp": Timestamp(date: Date())]
        
        if let image = image {
            ImageUploader.uploadImage(image: image) { imageUrl in
                data["imageUrl"] = imageUrl
                COLLECTION_CHANNELS.document().setData(data) { _ in
                    print("DEBUG: Did update channel")
                    self.didCreateChannel = true
                }
            }
        } else {
            COLLECTION_CHANNELS.document().setData(data) { _ in
                print("DEBUG: Did update channel")
                self.didCreateChannel = true 
            }
        }
        
    }
}
