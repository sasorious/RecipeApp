//
//  LoginView.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                authService.login(username: username, password: password) { success in
                    if success {
                        loginFailed = false
                    } else {
                        loginFailed = true
                    }
                }
            }
            .padding()

            if loginFailed {
                Text("Login Failed")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
