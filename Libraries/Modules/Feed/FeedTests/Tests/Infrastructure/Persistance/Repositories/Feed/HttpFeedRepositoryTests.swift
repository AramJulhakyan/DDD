//
//  HttpFeedRepositoryTests.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Feed

class HttpFeedRepositoryTests: XCTestCase {

    lazy var repository: HttpFeedRepository = { .init() }()

}

extension HttpFeedRepositoryTests {

    func testFindItem() {
        self.measure {
            let result = try? repository.find(itemId: "1").toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .success:
                XCTAssertTrue(true)

            default:
                XCTFail("Response not expected")
            }
        }
    }

    func testFindItemNotFound() {
        self.measure {
            let result = try? repository.find(itemId: "").toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .failure(let error):
                switch error {
                case .notFound:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Error not expected")
                }

            default:
                XCTFail("Response not expected")
            }
        }
    }

    func testFindAll() {
        self.measure {
            let result = try? repository.findAll().toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .success(let value):
                XCTAssertFalse(value.isEmpty)

            default:
                XCTFail("Response not expected")
            }
        }
    }

}
