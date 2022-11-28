//
//  EditProfileView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/19/22.
//

//if let profileImage = profileImage {
//    profileImage
//        .resizable()
//        .scaledToFill()
//        .frame(width: 64, height: 64)
//        .clipShape(Circle())
//} else {
//    Image(systemName: "person.fill")
//        .resizable()
//        .scaledToFill()
//        .frame(width: 64, height: 64)
//        .clipShape(Circle())
//}
//
//Button {
//    showImagePicker.toggle()
//} label: {
//    Text("Edit")
//}
//.sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
//    ImagePicker(image: $selectedImage)
//}

import SwiftUI
import PhotosUI
import Kingfisher

struct EditProfileView: View {
    @State private var fullname: String
    @State private var inEditMode = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImage: UIImage?
    @State private var data: Data?
    @ObservedObject var viewModel: EditProfileViewModel
    
    var nameChanged: Bool { return viewModel.user.fullname != fullname }
    
    init(_ viewmodel: EditProfileViewModel) {
        self.viewModel = viewmodel
        self._fullname = State(initialValue: viewmodel.user.fullname)
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 44) {
                //header
                
                VStack {
                    // Photo / edit / text
                    HStack {
                        // phot / edit
                        VStack {
                            if let data = data, let uiimage = UIImage(data: data) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                            } else {
                                KFImage(URL(string: viewModel.user.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(Circle())
                            }
                            
                            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                                Text("Edit")
                            }
                            .onChange(of: selectedItems) { newValue in
                                guard let item = selectedItems.first else { return }
                                item.loadTransferable(type: Data.self) { result in
                                    switch result {
                                    case .success(let data):
                                        if let data = data {
                                            self.data = data
                                            self.selectedImage = UIImage(data: data)
                                            self.inEditMode = true
                                        } else {
                                            print("Data is nil")
                                        }
                                    case .failure(let failure):
                                        fatalError(failure.localizedDescription)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        
                        Text("Enter your name or change your profile photo")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding([.bottom, .horizontal])
                    }
                    
                    Divider()
                        .padding(.horizontal)
                    
                    TextField("", text: $fullname) { _ in
                        self.inEditMode = true
                    }
                    .padding(8)
                }
                .background(Color.white)
                
                
                //status
                VStack(alignment: .leading) {
                    // status text
                    Text("Status")
                        .padding()
                        .foregroundColor(.gray)
                    // status
                    NavigationLink {
                        StatusSelectorView(viewModel)
                    } label: {
                        HStack {
                            Text(viewModel.user.status.title)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 1)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Edit Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                inEditMode || selectedImage != nil ? doneButton : nil
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                inEditMode ? cancelButton : nil
            }
        }
        .navigationBarBackButtonHidden(inEditMode)
    }
    
    var doneButton: some View {
        Button {
            UIApplication.shared.endEditing()
            inEditMode = false
            
            if nameChanged {
                viewModel.updateName(fullname)
            }
            
            if let selectedImage = selectedImage {
                viewModel.updateProfileImage(selectedImage)
            }
            
        } label: {
            Text("Done")
                .bold()
        }
    }
    
    var cancelButton: some View {
        Button {
            UIApplication.shared.endEditing()
            inEditMode = false
            self.data = nil
        } label: {
            Text("Cancel")
        }
    }
}
