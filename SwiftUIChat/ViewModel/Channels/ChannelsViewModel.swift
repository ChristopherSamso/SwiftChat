//
//  ChannelsViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/7/22.
//

import Foundation

class ChannelsViewModel: ObservableObject {
    @Published var channels = [Channel]()
    
    init() {
        fetchChannels()
    }
    
    func fetchChannels() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let query = COLLECTION_CHANNELS
            .whereField("uids", arrayContains: uid)
            .order(by: "timestamp", descending: true)
    
        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.channels = documents.compactMap({ try? $0.data(as: Channel.self)})
        }
    }
    
}
