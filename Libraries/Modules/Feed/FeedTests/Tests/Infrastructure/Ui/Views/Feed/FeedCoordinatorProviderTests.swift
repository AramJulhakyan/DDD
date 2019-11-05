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

    lazy var disposeBag: DisposeBag = { .init() }()

    var coordinator: FeedCoordinatorProvider = { .init(feedVM: nil, logger: nil) }()

}

extension FeedCoordinatorProviderTests {

    func testContent() {
        XCTAssertNotNil(coordinator.rootViewController)
        XCTAssertNotNil(coordinator.disposeBag)
        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }

    func testResultSuccess() {
        let items: [FeedItemDto] = [.mock]
        coordinator.bind(result: .success(items))

        XCTAssertFalse(coordinator.viewController.items.isEmpty)

        coordinator.viewController.items.enumerated().forEach { offset, item in
            let expected = items[offset]
            XCTAssertEqual(item.imageUrl, expected.imageUrl)
        }
    }

    func testGetStartInvocation() {
        let expectation = self.expectation(description: "default")
        var isCompleted = false
        coordinator.findItemsSubject.subscribe(
            onNext: {
                isCompleted = true
                expectation.fulfill()
        }).disposed(by: disposeBag)

        coordinator.start()

        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(isCompleted)
    }

}
