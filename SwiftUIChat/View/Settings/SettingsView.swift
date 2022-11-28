//
//  SettingsView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self.viewModel = EditProfileViewModel(user)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                NavigationLink() {
                    EditProfileView(viewModel)
                        .interactiveDismissDisabled()
                } label: {
                    SettingsHeaderView(user: viewModel.user)
                }
                
                VStack {
                    ForEach(SettingsCellViewModel.allCases, id: \.self) { viewModel in
                        SettingsCell(viewModel: viewModel)
                    }.padding(.top, -7)
                }
                
                Button {
                    AuthViewModel.shared.signOut()
                } label: {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .background(Color.white)
                }

                
                Spacer()
            }
        }
    }
}


