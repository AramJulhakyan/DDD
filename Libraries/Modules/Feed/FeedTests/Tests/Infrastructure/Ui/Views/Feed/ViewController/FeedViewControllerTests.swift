//
//  FeedViewControllerTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import MyUIKit
@testable import Feed

class FeedViewControllerTests: XCTestCase {

    lazy var viewController: FeedViewController? = { FeedViews.feedVC as? FeedViewController }()

}

// MARK: - Tests

extension FeedViewControllerTests {

    func testViewController() {
        XCTAssertNotNil(viewController)
    }

    func testViewDidLoad() {
        guard let viewController = viewController else { XCTFail("ViewController not found") ; return }

        self.measure {
            viewController.viewDidLoad()
            XCTAssertTrue(viewController.view.subviews.contains(viewController.itemCollectionView))
        }

    }

    func testUICollectionViewDataSource() {
        viewController?.items.append(.mock)
        viewController?.itemCollectionView.register(cell: MUKImageCollectionViewCell.self)

        let items = viewController?
            .collectionView(
                .init(frame: .zero, collectionViewLayout: .init()),
                numberOfItemsInSection: 0
        )

        XCTAssertEqual(viewController?.items.count, items ?? 0)
    }

    func testUICollectionViewDelegate() {
        let size = viewController?.collectionView(
            .init(frame: .zero, collectionViewLayout: .init()),
            layout: .init(),
            sizeForItemAt: .init(row: 0, section: 0)
        )

        XCTAssertEqual(size?.width, 80)
        XCTAssertEqual(size?.height, 80)
    }

}
