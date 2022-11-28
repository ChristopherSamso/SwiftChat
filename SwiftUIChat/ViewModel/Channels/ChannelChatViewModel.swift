//
//  ChannelChatViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/7/22.
//

import Foundation
import Firebase

class ChannelChatViewModel: ObservableObject {
    let channel: Channel
    @Published var messages = [Message]()
    @Published var messageToSetScroll: String?
    
    init(_ channel: Channel) {
        self.channel = channel
        fetchChannelMessages()
    }
    
    func fetchChannelMessages() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let channelId = channel.id else { return }
        
        let query = COLLECTION_CHANNELS
            .document(channelId)
            .collection("messages")
            .order(by: "timeStamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            
            let tempMessages = changes.compactMap({ try? $0.document.data(as: Message.self)})
            
            self.messages.append(contentsOf: tempMessages)
            
            for (index, message) in self.messages.enumerated() where message.fromId != currentUid {
                self.fetchUser(withUid: message.fromId) { user in
                    self.messages[index].user = user
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.messageToSetScroll = self.messages.last?.id
                }
            }
            
            
        }
    }
    
    func send(type: MessageType) {
        switch type {
        case .text(let messageText):
            sendChannelMessage(messageText: messageText)
        case .image(let image):
            ImageUploader.uploadImage(image: image) { imageUrl in
                self.sendChannelMessage(messageText: "Attachment: 1 image", imageUrl)
            }
        }
    }
    
    func sendChannelMessage(messageText: String, _ imageUrl: String? = nil) {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        guard let currentUid = currentUser.id else { return }
        guard let channelId = channel.id else { return }
        
        var data: [String: Any] = ["text": messageText,
                                   "fromId": currentUid,
                                   "toId": channelId,
                                   "read": "false",
                                   "timeStamp": Timestamp(date: Date())]
        
        if let imageUrl = imageUrl {
            data["imageUrl"] = imageUrl
        }
        
        COLLECTION_CHANNELS.document(channelId).collection("messages").document().setData(data)
        let lastMessage = "\(currentUser.username): \(messageText)"
        COLLECTION_CHANNELS.document(channelId).updateData(["lastMessage": lastMessage])
        COLLECTION_CHANNELS.document(channelId).updateData(["timestamp": Timestamp(date: Date())])
    }
    
    private func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
