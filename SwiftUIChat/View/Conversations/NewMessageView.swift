//
//  NewMessageView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import SwiftUI

struct NewMessageView: View {
    @Binding var showChatView: Bool
    @Binding var user: User?
    @Environment(\.presentationMode) var mode
    @State private var searchText = ""
    @ObservedObject var viewModel = NewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.users) { user in
                        Button {
                            showChatView.toggle()
                            self.user = user
                            mode.wrappedValue.dismiss()
                        } label: {
                            UserCell(user: user)
                        }
                    }
                }.searchable(text: $searchText)
            }
        }
    }
}
