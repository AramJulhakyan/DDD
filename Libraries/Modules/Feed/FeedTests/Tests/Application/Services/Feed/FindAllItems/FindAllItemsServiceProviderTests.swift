//
//  FindAllItemsServiceProviderTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Feed

class FindAllItemsServiceProviderTests: XCTestCase {

    lazy var repositoryMock: FeedRepositoryMock = { .init() }()

    lazy var service: FindAllItemsService = { FindAllItemsServiceProvider(repository: repositoryMock) }()

}

// MARK: - Tests

extension FindAllItemsServiceProviderTests {

    func testExecuteUnknownFailure() {
        repositoryMock.observable = .just(.failure(.server(code: 1, message: "Test")))
        self.measure {
            let result = try? service.execute().toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .unknown)
            default:
                XCTFail("Result not expected")
            }
        }
    }

    func testExecuteNotFoundFailure() {
        repositoryMock.observable = .just(.failure(.notFound(message: "Test")))
        self.measure {
            let result = try? service.execute().toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .notFound)
            default:
                XCTFail("Result not expected")
            }
        }
    }

    func testExecuteSuccess() {
        let mock = [FeedItemEntityMock()]
        repositoryMock.observable = .just(.success(mock))

        self.measure {
            let result = try? service.execute().toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .success(let value):
                value.enumerated().forEach { offset, item in
                    let entity = mock[offset]
                    XCTAssertEqual(item.imageUrl, entity.imageUrl)
                }

            default:
                XCTFail("Result not expected")
            }
        }
    }
}
