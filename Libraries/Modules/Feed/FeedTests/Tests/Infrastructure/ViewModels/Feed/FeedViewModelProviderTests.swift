//
//  FeedViewModelProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxCocoa
import RxBlocking

@testable import Feed

class FeedViewModelProviderTests: XCTestCase {

    lazy var findAllItemsServiceMock: FindAllItemsServiceMock = { .init() }()

    lazy var viewModel: FeedViewModel = {
        FeedViewModelProvider(logger: nil, findAllItemsService: findAllItemsServiceMock)
    }()

}

// MARK: - Tests

extension FeedViewModelProviderTests {

    func testTransformFailure() {
        let input = FeedViewModelProvider.Input(execute: BehaviorRelay(value: ()).asObservable())
        let output = viewModel.transform(input: input)

        let result = try? output.result.toBlocking().first()
        XCTAssertNotNil(result)

        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .unknown)
        default:
            XCTFail("Result not expected")
        }
    }

    func testTransformSuccess() {
        findAllItemsServiceMock.observable = .just(.success([.mock]))

        let input = FeedViewModelProvider.Input(execute: BehaviorRelay(value: ()).asObservable())
        let output = viewModel.transform(input: input)

        self.measure {
            let result = try? output.result.toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .success(let value):
                XCTAssertFalse(value.isEmpty)
            default:
                XCTFail("Result not expected")
            }
        }
    }

}
