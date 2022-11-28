//
//  UserCell.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    var body: some View {
            VStack {
                HStack {
                    // image
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                    
                    // user info
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold))
                        Text(user.fullname)
                            .font(.system(size: 15))
                    }
                    .foregroundColor(.black)
                    Spacer ()
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}
