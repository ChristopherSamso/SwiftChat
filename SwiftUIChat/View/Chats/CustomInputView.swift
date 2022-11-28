//
//  CustomInputView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import SwiftUI
import PhotosUI

struct CustomInputView: View {
    @Binding var text: String
    @State private var selectedItems: [PhotosPickerItem] = []
    @Binding var selectedImage: UIImage?
    @State private var image: Image?
    var action: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            
            HStack {
                if let image = image, selectedImage != nil {
                    ZStack(alignment: .topTrailing) {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 140, height: 140)
                            .cornerRadius(10)
                        
                        Button(action: {
                            selectedImage = nil
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .padding(8)
                        })
                        .background(Color(.gray))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                    }
                    Spacer()
                } else {
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                        Image(systemName: "photo")
                            .foregroundColor(.black)
                            .padding(.trailing, 4)
                    }
                    .onChange(of: selectedItems) { newValue in
                        guard let item = selectedItems.first else { return }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    selectedImage = UIImage(data: data)
                                    image = Image(uiImage: selectedImage!)
                                } else {
                                    print("Data is nil")
                                }
                            case .failure(let failure):
                                fatalError(failure.localizedDescription)
                            }
                        }
                    }
                    
                    TextField("Message..", text: $text, axis: .vertical)
                        .textFieldStyle(.plain)
                        .font(.body)
                        .frame(minHeight: 30)
                }
                
                
                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                }
                
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
}
