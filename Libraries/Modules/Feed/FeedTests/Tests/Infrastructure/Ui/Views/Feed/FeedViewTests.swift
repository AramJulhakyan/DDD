//
//  FeedViewTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class FeedViewTests: XCTestCase {

    struct Assembler: FeedView {/* empty */}

}

// MARK: - Tests

extension FeedViewTests {

    func testFeedView() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.viewController)

            let implementation = assembler.viewController() as? FeedViewController
            XCTAssertNotNil(implementation?.logger)
            XCTAssertNotNil(implementation?.feedVM)
        }
    }
}
