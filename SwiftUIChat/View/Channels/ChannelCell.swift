//
//  ChannelCell.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/1/22.
//

import SwiftUI
import Kingfisher

struct ChannelCell: View {
    let channel: Channel
    //  ChatsView(user: MOCK_USER)
    var body: some View {
            NavigationLink {
                LazyView(ChannelChatView(channel))
            } label: {
                ChannelCellView(channel: channel)
            }
    }
}

struct ChannelCellView: View {
    let channel: Channel
    var body: some View {
        VStack {
            HStack {
                // image
                if let groupImageUrl = channel.imageUrl {
                    KFImage(URL(string: groupImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.2.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
                
                
                // user info
                VStack(alignment: .leading, spacing: 4) {
                    Text(channel.name)
                        .font(.system(size: 14, weight: .semibold))
                    Text(channel.lastMessage)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.black)
                Spacer ()
            }
            .padding(.horizontal)
            
            Divider()
        }
        .padding(.top)
    }
}

