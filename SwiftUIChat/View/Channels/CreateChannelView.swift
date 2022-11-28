//
//  CreateChannelView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/3/22.
//

import SwiftUI
import PhotosUI

struct CreateChannelView: View {
    @Binding var show: Bool
    @State private var groupName = ""
    @State private var selectedImage: UIImage?
    @State private var groupImage: Image?
    @State private var selectedItems: [PhotosPickerItem] = []
    @ObservedObject var viewModel: CreateChannelViewModel
    @Environment(\.presentationMode) var mode
    
    init(_ selectableUsers: [SelectableUser], show: Binding<Bool>) {
        self.viewModel = CreateChannelViewModel(selectableUsers)
        self._show = show
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 32) {
                
                PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                    let image = groupImage == nil ? Image("plus_photo") : groupImage!
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                .padding(.leading)
                .onChange(of: selectedItems) { newValue in
                    guard let item = selectedItems.first else { return }
                    item.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                selectedImage = UIImage(data: data)
                                groupImage = Image(uiImage: selectedImage!)
                            } else {
                                print("Data is nil")
                            }
                        case .failure(let failure):
                            fatalError(failure.localizedDescription)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                    
                    TextField("Enter a name for your group", text: $groupName)
                        .font(.system(size: 15))
                    
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                    
                    Text("Please provide a group name and icon")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding()
            }
            Spacer()
        }
        .onReceive(viewModel.$didCreateChannel, perform: { completed in
            if completed {
                print("Function completed")
                show.toggle()
                mode.wrappedValue.dismiss()
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                createChannelButton
            }
        }
    }
    
    var createChannelButton: some View {
        Button {
            viewModel.createChannel(name: groupName, image: selectedImage)
        } label: {
            Text("Create")
                .bold()
                .disabled(groupName.isEmpty)
        }
    }
}
