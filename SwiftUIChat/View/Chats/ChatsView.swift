//
//  ChatsView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct ChatsView: View {
    @State private var messageText = ""
    @State private var selectedImage: UIImage?
    @ObservedObject var viewModel: ChatViewModel
    private let user: User
    
    init(user: User) {
        self.user = user
        self.viewModel = ChatViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            // Messages
            ScrollViewReader { scrollView in
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageView(viewModel: MessageViewModel(message), config: .privateMessage).id(message.timeStamp)
                        }
                        .onAppear {
                            scrollView.scrollTo(viewModel.messages.last?.timeStamp)
                        }
                        .animation(Animation.spring(response: 0.65))
                        .onChange(of: viewModel.messages.count) { int in
                            scrollView.scrollTo(viewModel.messages.last?.timeStamp)
                        }
                        .animation(Animation.spring(response: 0.65))
                    }
                    .animation(Animation.easeIn(duration: 0.65))
                }
            }
            
            // InputView
            CustomInputView(text: $messageText, selectedImage: $selectedImage, action: sendMessage)
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func sendMessage() {
        if let image = selectedImage {
            viewModel.send(type: .image(image))
            selectedImage = nil
        } else {
            viewModel.send(type: .text(messageText))
            messageText = ""
        }
    }
}
