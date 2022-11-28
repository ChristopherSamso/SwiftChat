//
//  ConversationsViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/31/22.
//

import Foundation
import SwiftUI

class ConversationViewModel: ObservableObject {
    @Published var recentConversations = [Message]()
    
    init() {
        fetchRecentMessages()
    }
    
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

        let query = COLLECTION_MESSAGES
            .document(uid)
            .collection("recent-messages")
            .order(by: "timeStamp", descending: true)

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documents else { return }

            self.recentConversations = changes.compactMap({ try? $0.data(as: Message.self)})
        }
    }
    
}
