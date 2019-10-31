//
//  FeedApplicationServicesTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class FeedApplicationServicesTests: XCTestCase {

    struct Assembler: FeedApplicationServices {/* empty */}

}

// MARK: - Tests

extension FeedApplicationServicesTests {

    func testDependences() {
        let assembler = Assembler() as FeedApplicationServices

        self.measure {
            XCTAssertNotNil(assembler.findAllItems)
        }
    }

}
