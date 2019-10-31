//
//  FeedViewsTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class FeedViewsTests: XCTestCase {/* empty */}

// MARK: - Tests

extension FeedViewsTests {

    func testFeedViews() {
        self.measure {
            XCTAssertNotNil(FeedViews.feedVC)
        }
    }

}
