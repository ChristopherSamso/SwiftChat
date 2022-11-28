//
//  SelectGroupMembersView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/1/22.
//

import SwiftUI

struct SelectGroupMembersView: View {
    @Binding var show: Bool
    @State private var searchText = ""
    @ObservedObject var viewModel = SelectGroupMembersViewModel()
    @Environment(\.presentationMode) var mode
    var body: some View {
        NavigationView {
            VStack {
                
                // selected users view
                if !viewModel.selectedUsers.isEmpty {
                    SelectedGroupMembersView(viewModel: viewModel)
                        .scrollIndicators(.hidden)
                }
                
                ScrollView {
                    VStack {
                        ForEach(searchText.isEmpty ? viewModel.selectableUsers :
                                viewModel.filteredUsers(searchText)) { selectableUser in
                            Button {
                                viewModel.selectUser(selectableUser, isSelected: !selectableUser.isSelected)
                            } label: {
                                SelectableUserCell(viewModel: SelectableUserCellViewModel(selectableUser: selectableUser))
                            }
                            
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("New Group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    nextButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
            }
        }
    }
    
    var nextButton: some View {
        NavigationLink {
            CreateChannelView(viewModel.selectedUsers, show: $show)
        } label: {
            Text("Next").bold()
        }
    }
    
    var cancelButton: some View {
        Button {
            mode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
}

