//
//  LazyView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 11/9/22.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

