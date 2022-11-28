//
//  LogInView.swift
//  SwiftUIChat
//
//  Created by Christopher Samso on 10/13/22.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack() {
                AuthenticationHeaderView(title1: "Hello.", title2: "Welome back")
                
                // Login Info
                VStack(spacing: 40) {
                    
                    CustomInputField(imageName: "envelope",
                                     placeHolderText: "Email",
                                     text: $email)
                    
                    CustomInputField(imageName: "lock",
                                     placeHolderText: "Password",
                                     isSecureField: true,
                                     text: $password)

                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                
                HStack {
                    Spacer()
                    NavigationLink {
                        Text("Reset password view...")
                    } label: {
                        Text("Forgot password?")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                            .padding(.top)
                            .padding(.trailing, 24)
                    }
                }
                
                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule()).padding()
                }
                .shadow(color: .gray.opacity(0.75), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView().navigationBarHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.footnote)
                        Text("Sign Up")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
