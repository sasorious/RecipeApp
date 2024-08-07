//
//  AuthServiceTests.swift
//  RecipeAppTests
//
//  Created by Syafiq A. Sobri on 06/08/2024.
//

import XCTest
@testable import RecipeApp

class AuthServiceTests: XCTestCase {

    var authService: AuthService!

    override func setUp() {
        super.setUp()
        authService = AuthService()
    }

    override func tearDown() {
        authService = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login should succeed")

        authService.login(username: "username", password: "password") { success in
            XCTAssertTrue(success, "Login should succeed for correct credentials")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoginFailure() {
        let expectation = self.expectation(description: "Login should fail")

        authService.login(username: "wrongUser", password: "wrongPassword") { success in
            XCTAssertFalse(success, "Login should fail for incorrect credentials")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
