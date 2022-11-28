//
//  EditProfileViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/10/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    func updateProfileImage(_ image: UIImage) {
        guard let uid = user.id else { return }
        let storageRef = Storage.storage().reference(forURL: user.profileImageUrl)
        storageRef.delete { error in
            if let error = error {
                errorHandler(withErrorType: "Delete user image", errorMessage: error.localizedDescription)
                return
            }
            ImageUploader.uploadImage(image: image) { URL in
                COLLECTION_USERS.document(uid).updateData([DatabaseKeysUser.profileImageUrl: URL]) { error in
                    if let error = error {
                        errorHandler(withErrorType: "Upload user image", errorMessage: error.localizedDescription)
                        return
                    }
                    self.user.profileImageUrl = URL
                }
            }
        }
    }
    
    func updateName(_ name: String) {
        guard let uid = user.id else { return }
        COLLECTION_USERS.document(uid).updateData([DatabaseKeysUser.fullname: name]) { error in
            if let error = error {
                errorHandler(withErrorType: "Update user full name", errorMessage: error.localizedDescription)
                return
            }
            self.user.fullname = name
        }
    }
    
    func updateStatus(_ status: UserStatus) {
        guard let uid = user.id else { return }
        COLLECTION_USERS.document(uid).updateData(["status": status.rawValue]) { error in
            if let error = error {
                errorHandler(withErrorType: "Update user status", errorMessage: error.localizedDescription)
                return
            }
            self.user.status = status
        }
    }
}
