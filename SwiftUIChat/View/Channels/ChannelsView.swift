//
//  ChannelsView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct ChannelsView: View {
    @State private var showCreateGroupView = false
    @ObservedObject var viewModel = ChannelsViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(viewModel.channels) { channel in
                        ChannelCell(channel: channel)
                    }
                }
            }
            
            FloatingButton(show: $showCreateGroupView)
                .sheet(isPresented: $showCreateGroupView) {
                    SelectGroupMembersView(show: $showCreateGroupView)
                }
        }
    }
}

struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsView()
    }
}

struct FloatingButton: View {
    @Binding var show: Bool
    var body: some View {
        Button {
            show.toggle()
        } label: {
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
        }
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
    }
}
