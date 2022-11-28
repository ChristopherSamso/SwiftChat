//
//  Extensions.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/11/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
