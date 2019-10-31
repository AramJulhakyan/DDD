//
//  PersistanceTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

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
