//
//  FeedItemCoordinatorProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 07/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Feed

class FeedItemCoordinatorProviderTests: XCTestCase {

    lazy var coordinator: FeedItemCoordinator = {
        FeedItemCoordinatorProvider(viewController: .init(), logger: nil)
    }()

}

// MARK: - Tests

extension FeedItemCoordinatorProviderTests {

    func testContent() {
        XCTAssertNotNil(coordinator.rootViewController)
        XCTAssertTrue(coordinator.rootViewController is FeedItemViewController)
        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }
}
