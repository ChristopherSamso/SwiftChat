//
//  ProfilePhotoSelector.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/26/22.
//

import SwiftUI
import PhotosUI

struct ProfilePhotoSelector: View {
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State private var selectedItems: [PhotosPickerItem] = []
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            AuthenticationHeaderView(title1: "Setup account", title2: "Add a profile photo")
            
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .clipShape(Circle())
                        .modifier(ProfileImageModifier())
                        .padding(.top, 44)
                } else {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .modifier(ProfileImageModifier())
                        .padding(.top, 44)
                }
            }
            .onChange(of: selectedItems) { newValue in
                guard let item = selectedItems.first else { return }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            selectedImage = UIImage(data: data)
                            profileImage = Image(uiImage: selectedImage!)
                        } else {
                            print("Data is nil")
                        }
                    case .failure(let failure):
                        fatalError(failure.localizedDescription)
                    }
                }
            }
            
            
            if let selectedImage = selectedImage {
                Button {
                    viewModel.uploadProfileImage(selectedImage)
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.75), radius: 10, x: 0, y: 0)
            }
            
            Spacer ()
            
        }
        .navigationBarBackButtonHidden(true)
        .transition(.slide)
        .ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: 180, height: 180)
    }
}

struct ProfilePhotoSelector_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelector()
    }
}
