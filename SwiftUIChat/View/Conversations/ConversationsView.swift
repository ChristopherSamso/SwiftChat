//
//  ConversationsView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct ConversationsView: View {
    @State private var showNewMessageView = false
    @State private var showChatView = false
    @State var selectedUser: User?
    @ObservedObject var viewModel = ConversationViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            // Chats
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.recentConversations) { message in
                        ConversationCell(viewModel: ConversationCellViewModel(message))
                            .animation(Animation.easeInOut)
                    }
                }
            }
            
            //Floating Button
            FloatingButton(show: $showNewMessageView)
            .sheet(isPresented: $showNewMessageView) {
                NewMessageView(showChatView: $showChatView, user: $selectedUser)
            }
        }
        .navigationDestination(isPresented: $showChatView) {
            if let user = selectedUser {
                LazyView(ChatsView(user: user))
            }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
    }
}
