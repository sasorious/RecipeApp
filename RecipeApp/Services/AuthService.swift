//
//  AuthService.swift
//  RecipeApp
//
//  Created by Syafiq A. Sobri on 05/08/2024.
//

import Foundation
import RxSwift
import RxCocoa

class AuthService: ObservableObject {
    @Published var isAuthenticated = false

    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Simulated login process
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if username == "username" && password == "password" {
                self.isAuthenticated = true
                completion(true)
            } else {
                self.isAuthenticated = false
                completion(false)
            }
        }
    }

    func logout() {
        self.isAuthenticated = false
    }

    func checkAuthentication() -> Bool {
        return isAuthenticated
    }
}
