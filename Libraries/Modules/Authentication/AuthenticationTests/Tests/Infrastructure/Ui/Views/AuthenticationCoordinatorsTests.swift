//
//  AuthenticationViewsTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class AuthenticationCoordinatorsTests: XCTestCase {/* empty */}

// MARK: - Tests

extension AuthenticationCoordinatorsTests {

    func testAuthenticationViews() {
        self.measure {
            XCTAssertNotNil(AuthenticationCoordinators.loginCoordinator)
        }
    }

}
