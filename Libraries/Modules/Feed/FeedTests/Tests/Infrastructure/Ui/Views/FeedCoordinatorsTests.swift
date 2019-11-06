//
//  FeedViewsTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class FeedCoordinatorsTests: XCTestCase {/* empty */}

// MARK: - Tests

extension FeedCoordinatorsTests {

    func testFeedViews() {
        self.measure {
            XCTAssertNotNil(FeedCoordinators.feedCoordinator)
            XCTAssertNotNil(FeedCoordinators.findItemCoordinator(itemId: "test"))
        }
    }

}
