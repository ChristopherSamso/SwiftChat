//
//  SelectableUserCellViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/3/22.
//

import Foundation
import SwiftUI
struct SelectableUserCellViewModel {
    let selectableUser: SelectableUser
    
    var profileImageUrl: URL {
        return URL(string: selectableUser.user.profileImageUrl)!
    }
    
    var username: String {
        return selectableUser.username
    }
    
    var fullname: String {
        return selectableUser.fullname
    }
    
    var selectedImageName: String {
        return selectableUser.isSelected ? "checkmark.circle.fill" : "circle"
    }
    
    var selectedImageColor: Color {
        return selectableUser.isSelected ? .blue : .gray
    }
}
