//
//  AuthApplicationServicesTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class AuthApplicationServicesTests: XCTestCase {

    struct Assembler: AuthApplicationServices {/* empty */}

}

// MARK: - Tests

extension AuthApplicationServicesTests {

    func testAuthApplicationServices() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.login)
        }
    }

}
