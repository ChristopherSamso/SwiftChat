//
//  StatusSelectorView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/20/22.
//

import SwiftUI

struct StatusSelectorView: View {
    
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(_ viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) { // Main container
                    Text("CURRENTLY SET TO")
                        .padding(8)
                        .foregroundColor(.gray)
                    
                    StatusCell(status: viewModel.user.status)
                    
                    
                    Text("SELECT YOUR STATUS")
                        .padding()
                        .foregroundColor(.gray)
                    
                    
                    //ForEach
                    ForEach(UserStatus.allCases.filter({ $0 != .notConfigured }), id: \.self) { status in
                        Button {
                            viewModel.updateStatus(status)
                        } label: {
                            StatusCell(status: status)
                        }

                    }

                }.padding(.top, 1)
            }
        }
    }
}

struct StatusCell: View {
    let status: UserStatus
    var body: some View {
        HStack {
            Text(status.title)
                .foregroundColor(Color.black)
            Spacer()
        }
        .frame(height: 56)
        .padding(.horizontal)
        .background(Color.white)
        .padding(-3)
    }
}
