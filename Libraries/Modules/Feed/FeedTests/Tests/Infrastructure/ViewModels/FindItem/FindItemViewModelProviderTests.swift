//
//  FindItemViewModelProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 07/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift

@testable import Feed

class FindItemViewModelProviderTests: XCTestCase {

    lazy var service: FindItemServiceMock = { .init() }()

    lazy var disposeBag: DisposeBag = { .init() }()

//    lazy var viewModel: FindItemViewModel = {
//        FindItemViewModelProvider(itemId: "test", logger: nil, findItemService: service)
//    }()
}

// MARK: - Tests

extension FindItemViewModelProviderTests {

    func testItemIdInvalidFailure() {
        let viewModel = FindItemViewModelProvider(itemId: "", logger: nil, findItemService: service)
        let input = FindItemViewModelProvider.Input(execute: BehaviorSubject(value: ()))
        let output = viewModel.transform(input: input)

        let expectation = self.expectation(description: "default")

        var error: FeedError?

        output.result.drive(onNext: { result in
            switch result {
            case .failure(let value):
                error = value
            default:
                break
            }

            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(error)
        switch error {
        case .notFound:
            XCTAssertTrue(true)
        default:
            XCTFail("Unexpected response")
        }
    }

    func testSuccess() {
        let mock = FeedItemDto.mock
        service.observable = .just(.success(mock))
        let viewModel = FindItemViewModelProvider(itemId: "test", logger: nil, findItemService: service)
        let input = FindItemViewModelProvider.Input(execute: BehaviorSubject(value: ()))
        let output = viewModel.transform(input: input)

        let expectation = self.expectation(description: "default")

        var item: FeedItemDto?

        output.result.drive(onNext: { result in
            switch result {
            case .success(let value):
                item = value
            default:
                break
            }

            expectation.fulfill()
        }).disposed(by: disposeBag)

        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(item)
        XCTAssertEqual(mock.itemId, item?.itemId)
        XCTAssertEqual(mock.imageUrl, item?.imageUrl)
    }

}
