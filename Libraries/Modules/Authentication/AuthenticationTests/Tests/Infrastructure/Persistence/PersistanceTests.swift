//
//  PersistenceTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class PersistanceTests: XCTestCase {

    struct Assembler: Persistance {/* empty */}

}

// MARK: - Tests

extension PersistanceTests {

    func testPersistance() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.repositories)
        }
    }

}
