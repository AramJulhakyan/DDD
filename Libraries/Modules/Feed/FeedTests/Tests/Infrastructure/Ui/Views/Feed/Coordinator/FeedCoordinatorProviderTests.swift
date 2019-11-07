//
//  FeedCoordinatorProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift

@testable import Feed

class FeedCoordinatorProviderTests: XCTestCase {

    var coordinator: FeedCoordinatorProvider = { .init(viewController: .init(), logger: nil) }()

}

extension FeedCoordinatorProviderTests {

    func testContent() {
        self.measure {
            XCTAssertNotNil(coordinator.rootViewController)
            XCTAssertTrue(coordinator.childCoordinators.isEmpty)
        }
    }

}
