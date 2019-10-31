//
//  PersistanceRepositoriesTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class PersistanceRepositoriesTests: XCTestCase {

    struct Assembler: PersistanceRepositories {/* empty */}

}

extension PersistanceRepositoriesTests {

    func testPersistanceRepositories() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.feed)
        }
    }

}
