//
//  ChannelsChatView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/7/22.
//

import SwiftUI

struct ChannelChatView: View {
    @ObservedObject var viewModel: ChannelChatViewModel
    @State private var messageText = ""
    @State private var selectedImage: UIImage?
    
    init(_ channel: Channel) {
        self.viewModel = ChannelChatViewModel(channel)
    }
    
    var body: some View {
        VStack {
            // Messages
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            MessageView(viewModel: MessageViewModel(message), config: .groupMessage).id(message.timeStamp)
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
                .padding(.top, 2)
        }
        .navigationTitle(viewModel.channel.name)
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

