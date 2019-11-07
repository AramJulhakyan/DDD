//
//  FindItemServiceProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 07/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Feed

class FindItemServiceProviderTests: XCTestCase {

    lazy var repository: FeedRepositoryMock = { .init() }()

    lazy var service: FindItemService = { FindItemServiceProvider(logger: nil, repository: repository) }()

}

// MARK: - Tests

extension FindItemServiceProviderTests {

    func testExecuteNotFoundFailure() {
        repository.findItemObservable = .just(.failure(.notFound(message: "test")))
        let result = try? service.execute(itemId: "test").toBlocking().first()
        XCTAssertNotNil(result)

        switch result {
        case .failure(let error):
            switch error {
            case .notFound:
                XCTAssertTrue(true)
            default:
                XCTFail("Invalid error")
            }
        default:
            XCTFail("Unexpected result")
        }
    }

    func testExecuteUnknownFailure() {
        repository.findItemObservable = .just(.failure(.badRequest(message: "test")))
        let result = try? service.execute(itemId: "test").toBlocking().first()
        XCTAssertNotNil(result)

        switch result {
        case .failure(let error):
            switch error {
            case .unknown:
                XCTAssertTrue(true)
            default:
                XCTFail("Invalid error")
            }
        default:
            XCTFail("Unexpected result")
        }
    }

    func testExecuteSuccess() {
        let mock = FeedItemEntityMock()
        repository.findItemObservable = .just(.success(mock))

        let result = try? service.execute(itemId: "test").toBlocking().first()
        XCTAssertNotNil(result)

        switch result {
        case .success(let item):
            XCTAssertEqual(item.itemId, mock.itemId)
            XCTAssertEqual(item.imageUrl, mock.imageUrl)
        default:
            XCTFail("Unexpected result")
        }
    }

}
