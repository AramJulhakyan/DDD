//
//  FeedViewControllerTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift

@testable import MyUIKit
@testable import Feed

class FeedViewControllerTests: XCTestCase {

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var viewModel: FeedViewModelMock = { .init() }()

    lazy var viewController: FeedViewController = {
        let instance = FeedViewController()
        instance.viewModel = viewModel

        return instance
    }()

}

// MARK: - Tests

extension FeedViewControllerTests {

    func testViewController() {
        XCTAssertNotNil(viewController)
    }

    func testViewDidLoad() {
        self.measure {
            viewController.viewDidLoad()
            XCTAssertTrue(viewController.view.subviews.contains(viewController.itemCollectionView))
        }

    }

    func testUICollectionViewDataSource() {
        let mock: [FeedItemDto] = [.mock]
        viewController.bind(result: .success(mock))

        let numbOfItems = viewController
            .collectionView(
                .init(frame: .zero, collectionViewLayout: .init()),
                numberOfItemsInSection: 0
        )

        XCTAssertEqual(numbOfItems, mock.count)
    }

    func testUICollectionViewDelegate() {
        let size = viewController.collectionView(
            .init(frame: .zero, collectionViewLayout: .init()),
            layout: .init(),
            sizeForItemAt: .init(row: 0, section: 0)
        )

        XCTAssertEqual(size.width, 80)
        XCTAssertEqual(size.height, 80)
    }

    func testFindItemsFromViewDidLoad() {
        let mock: [FeedItemDto] = [.mock]
        viewModel.observable = .just(.success(mock))

        self.measure {
            viewController.viewDidLoad()

            let numbOfItems = viewController
                .collectionView(
                    .init(frame: .zero, collectionViewLayout: .init()),
                    numberOfItemsInSection: 0
            )

            XCTAssertEqual(numbOfItems, mock.count)
        }
    }

    func testItemDidSelect() {
        let mock: [FeedItemDto] = [.mock]
        viewController.bind(result: .success(mock))

        let expectation = self.expectation(description: "default")
        var itemId: String?

        viewController.itemDidSelect.drive(onNext: { value in
            itemId = value
            expectation.fulfill()
        }).disposed(by: disposeBag)

        viewController.collectionView(
            .init(frame: .zero, collectionViewLayout: .init()),
            didSelectItemAt: .init(row: 0, section: 0)
        )

        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(itemId)
        XCTAssertEqual(itemId, mock.first?.itemId)
    }

    func testCollectionViewInsets() {
        let mock: [FeedItemDto] = [.mock]
        viewController.bind(result: .success(mock))

        let inset = viewController.collectionView(
            .init(frame: .zero, collectionViewLayout: .init()),
            layout: .init(),
            insetForSectionAt: 0
        )

        let expectedInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        XCTAssertEqual(inset, expectedInset)
    }

    func testCollectionViewCell() {
        let mock: [FeedItemDto] = [.mock]
        viewController.bind(result: .success(mock))

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.register(cell: MUKImageCollectionViewCell.self)

        let cell = viewController.collectionView(
            collectionView,
            cellForItemAt: .init(item: 0, section: 0)
        )

        XCTAssertTrue(cell is MUKImageCollectionViewCell)
    }

}
