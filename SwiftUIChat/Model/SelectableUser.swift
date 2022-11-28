//
//  SelectableUser.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/2/22.
//

import Foundation

struct SelectableUser: Identifiable {
    let user: User
    var isSelected: Bool = false
    
    var id: String {
        return user.id ?? NSUUID().uuidString
    }
    
    var username: String { return user.username }
    
    var fullname: String { return user.fullname }
}
