//
//  UserCell.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import SwiftUI
import Kingfisher

struct ConversationCell: View {
    @ObservedObject var viewModel: ConversationCellViewModel
    //  ChatsView(user: MOCK_USER)
    var body: some View {
        if let user = viewModel.message.user {
            NavigationLink {
                LazyView(ChatsView(user: user))
            } label: {
                cellView(viewModel: viewModel)
            }
        }
    }
}

struct cellView: View {
    let viewModel: ConversationCellViewModel
    var body: some View {
        VStack {
            HStack {
                // image
                KFImage(viewModel.chatPartnerProfileImageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                // user info
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.fullname)
                        .font(.system(size: 14, weight: .semibold))
                    Text(viewModel.message.text)
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
