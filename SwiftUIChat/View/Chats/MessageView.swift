//
//  MessageView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let viewModel: MessageViewModel
    let config: MessageViewConfig

    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer ()
                if viewModel.isImageMessage {
                    KFImage(viewModel.messageImageUrl)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 800)
                        .cornerRadius(10)
                        .padding(.trailing)
                } else {
                    Text(viewModel.message.text)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(ChatBubble(isFromCurrentUser: true))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.leading, 100)
                        .font(.system(size: 15))
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    if config == .groupMessage {
                        Text(viewModel.message.user?.fullname ?? "")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .padding(.leading, 56)
                    }
                    HStack(alignment: .bottom) {
                        KFImage(viewModel.profileImageUrl)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                        
                        if viewModel.isImageMessage {
                            KFImage(viewModel.messageImageUrl)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, maxHeight: 800)
                                .cornerRadius(10)
                        } else {
                            Text(viewModel.message.text)
                                .padding(12)
                                .background(Color(.systemGray5))
                                .font(.system(size: 15))
                                .clipShape(ChatBubble(isFromCurrentUser: false))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.trailing, 80)
                }
                
                Spacer ()
            }
        }
        .animation(Animation.spring(response: 1))
    }
}
