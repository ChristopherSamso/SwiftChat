//
//  Constants.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/26/22.
//

import Foundation
import Firebase
import SwiftUI



let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
let COLLECTION_CHANNELS = Firestore.firestore().collection("channels")

enum MessageViewConfig {
    case privateMessage
    case groupMessage
}

enum MessageType {
    case text(String)
    case image(UIImage)
}

enum UserStatus: Int, CaseIterable, Codable {
    case notConfigured
    case available
    case busy
    case atschool
    case atmovies
    case atwork
    case battery
    case inmeet
    case atgym
    case sleep
    case urgent
    
    var title: String {
        switch self {
        case .notConfigured: return "Click here to update your status"
        case .available: return "Available 🫡"
        case .busy: return "Busy 😤"
        case .atschool: return "At school 🏫"
        case .atmovies: return "At the movies 🍿"
        case .atwork: return "At work 💻"
        case .battery: return "Battery about to die 🪫"
        case .inmeet: return "In meeting 🧑‍💻"
        case .atgym: return "At the gym 🏋🏽‍♀️"
        case .sleep: return "Sleeping 😴"
        case .urgent: return "Urgent calls only 🫠"
        }
    }
}

enum DatabaseKeysUser: String {
    case username = "username"
    case fullname = "fullname"
    case email = "email"
    case profileImageUrl = "profileImageUrl"
}


func errorHandler(withErrorType errorType: String, errorMessage: String) {
    print("DEBUG: \(errorType) failed with \(errorMessage)")
}

