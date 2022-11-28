//
//  AuthViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/25/22.
//

import Foundation
import Firebase
import UIKit

class AuthViewModel: NSObject, ObservableObject {
    @Published var didAuthUser = false
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var tempCurrentUser: FirebaseAuth.User?
    
    static let shared = AuthViewModel()
    
    override init() {
        super.init()
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func registerUser(withEmail email: String, password: String, username: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempCurrentUser = user
            
            let data = ["email": email,
                        "username": username,
                        "fullname": fullname,
                        "status": UserStatus.notConfigured.rawValue]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("DEBUG: Succesfully created user")
                self.didAuthUser = true 
            }
        }
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempCurrentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageUrl in
            COLLECTION_USERS.document(uid).updateData(["profileImageUrl": imageUrl]) { _ in
                print("DEBUG: Succesfully updated user data with image")
                self.userSession = self.tempCurrentUser
                self.fetchUser()
            }
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            print("DEBUG: User object \(user)")
            self.currentUser = user
        }
    }
    
    
    func signOut() {
        self.userSession = nil
        self.currentUser = nil
        self.didAuthUser = false
        try? Auth.auth().signOut()
    }
}
