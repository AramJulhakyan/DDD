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

class HttpFeedRepositoryTests: XCTestCase {/* empty */}

extension HttpFeedRepositoryTests {

    func testFindAll() {
        let repository = HttpFeedRepository()
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
