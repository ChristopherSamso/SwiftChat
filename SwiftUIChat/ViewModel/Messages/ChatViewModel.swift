//
//  ChatViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFunctions

class ChatViewModel: ObservableObject {
    let user: User
    lazy var functions = Functions.functions()
    
    @Published var messages = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }
        
        let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timeStamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            let messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
            self.messages.append(contentsOf: messages)
            
            for (index, message) in self.messages.enumerated() where message.fromId != currentUid {
                self.messages[index].user = self.user
            }
            
            
        }
    }
    
    func send(type: MessageType) {
        switch type {
        case .text(let messageText):
            sendMessage(messageText)
        case .image(let image):
            ImageUploader.uploadImage(image: image) { imageUrl in
                self.sendMessage("Attachment: 1 image", imageUrl)
            }
        }
    }
    
    func sendMessage(_ messageText: String, _ imageUrl: String? = nil) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }
        let chatPartnerToken = user.fcmToken
        
        
        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentUid)
        let recentCurrentRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        let messageId = currentUserRef.documentID
        
        var data: [String : Any] = [ "fromId": currentUid,
                                     "toId": chatPartnerId,
                                     "read": "false",
                                     "text": messageText,
                                     "timeStamp": Timestamp(date: Date())]
        
        if let imageUrl = imageUrl {
            data["imageUrl"] = imageUrl
        }
        
        if let chatPartnerToken = chatPartnerToken {
            notify(["fcmToken": chatPartnerToken,
                              "fromId": currentUid,
                              "text": messageText])
        }
        
        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)
    }
    
    func notify(_ data: [String : Any]) {
        functions.httpsCallable("sendNotification").call(data) { result, error in
            
            if let result = result {
                print("DEBUG: \(result)")
            }
            
        }
    }
}

//    var mockMessages: [Message] {
//        [
//            .init(isFromCurrentUser: true, messageText: "Yooo whats good"),
//            .init(isFromCurrentUser: false, messageText: "Chillin bro"),
//            .init(isFromCurrentUser: true, messageText: "Same same... wyd tn"),
//            .init(isFromCurrentUser: false, messageText: "HMMM thinking of going out"),
//            .init(isFromCurrentUser: true, messageText: "ooo where to?"),
//            .init(isFromCurrentUser: false, messageText: "Thinking rhino 🦏"),
//            .init(isFromCurrentUser: true, messageText: "I'm down... what time?"),
//            .init(isFromCurrentUser: false, messageText: "9pm Larimer Lounge"),
//            .init(isFromCurrentUser: true, messageText: "See you there"),
//            .init(isFromCurrentUser: false, messageText: "Bet")
//        ]
//    }
//
