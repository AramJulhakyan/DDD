//
//  AuthenticationServicesTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class AuthenticationServicesTests: XCTestCase {/* empty */}

// MARK: - Tests

extension AuthenticationServicesTests {

    func testAuthenticationServices() {
        self.measure {
            XCTAssertNotNil(AuthenticationServices.autoLogin)
        }
    }

}
