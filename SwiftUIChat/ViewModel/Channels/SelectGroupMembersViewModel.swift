//
//  SelectGroupMembersViewModel.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/3/22.
//

import Foundation
import Firebase

class SelectGroupMembersViewModel: ObservableObject {
    @Published var selectableUsers = [SelectableUser]()
    @Published var selectedUsers = [SelectableUser]()
    init() {
       fetchUsers()
    }
    
    // Fetching Users
    
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let users = documents.compactMap({ try? $0.data(as: User.self)})
                .filter({$0.id != AuthViewModel.shared.userSession?.uid})
            
            self.selectableUsers = users.map({ SelectableUser(user: $0)})
        }
    }
    
    // Select/deselect users
    
    func selectUser(_ user: SelectableUser, isSelected: Bool) {
        guard let index = selectableUsers.firstIndex(where: { $0.id == user.id }) else { return }
        
        selectableUsers[index].isSelected = isSelected
        
        if isSelected {
            selectedUsers.append(selectableUsers[index])
        } else {
            selectedUsers.removeAll(where: { $0.id == user.id})
        }
                
    }
    
    // Filter users for search
    
    func filteredUsers(_ query: String) -> [SelectableUser] {
        let lowerCasedQuery = query.lowercased()
        return selectableUsers.filter({
            $0.username.localizedStandardContains(lowerCasedQuery) ||
            $0.fullname.localizedStandardContains(lowerCasedQuery)
        })
    }
    
}
