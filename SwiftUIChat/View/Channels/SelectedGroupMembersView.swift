//
//  SelectedGroupMembersView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/1/22.
//

import SwiftUI
import Kingfisher

struct SelectedGroupMembersView: View {
    
    @ObservedObject var viewModel: SelectGroupMembersViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.selectedUsers) { selectedUser in
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            KFImage(URL(string: selectedUser.user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            
                            Text(selectedUser.fullname)
                                .font(.system(size: 11, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 64)
                        
                        Button {
                            viewModel.selectUser(selectedUser, isSelected: false)
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(4)
                        }
                        .background(Color(.red))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                }
            }
        }
        .animation(Animation.spring())
        .padding()
    }
}

//struct SelectedGroupMembersView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedGroupMembersView()
//    }
//}
