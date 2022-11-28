//
//  AuthenticationHeaderView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    let title1: String
    let title2: String
    var body: some View {
        // Header View
        VStack(alignment: .leading) {
            HStack { Spacer () } // Quick way to give the Vstack a full width view
            Text(title1).font(.largeTitle).fontWeight(.semibold)
            Text(title2).font(.largeTitle).fontWeight(.semibold)
        }.frame(height: 260).padding(.leading).background(Color(.systemBlue)).foregroundColor(Color(.white)).clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeaderView(title1: "Hello.", title2: "Welcome back")
    }
}
