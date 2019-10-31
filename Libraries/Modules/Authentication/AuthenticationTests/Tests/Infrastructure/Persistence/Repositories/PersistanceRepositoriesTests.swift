//
//  PersistanceRepositoriesTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class PersistanceRepositoriesTests: XCTestCase {

    struct Assembler: PersistanceRepositories {/* empty */}

}

// MARK: - Tests

extension PersistanceRepositoriesTests {

    func testPersistanceRepositories() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.auth)
        }
    }

}
