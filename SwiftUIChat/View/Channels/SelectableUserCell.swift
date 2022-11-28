//
//  SelectableUserCell.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/2/22.
//

import SwiftUI
import Kingfisher

struct SelectableUserCell: View {
    let viewModel: SelectableUserCellViewModel
    
    var body: some View {
            VStack {
                HStack {
                    // image
                    KFImage(viewModel.profileImageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                    
                    // user info
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.username)
                            .font(.system(size: 14, weight: .semibold))
                        Text(viewModel.fullname)
                            .font(.system(size: 15))
                    }
                    .foregroundColor(.black)
                    Spacer ()
                    Image(systemName: viewModel.selectedImageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(viewModel.selectedImageColor)
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
}

