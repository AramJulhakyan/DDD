//
//  HttpAuthRepositoryTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Authentication

class HttpAuthRepositoryTests: XCTestCase {

    lazy var repository: HttpAuthRepository = { .init() }()

}

// MARK: - Tests

extension HttpAuthRepositoryTests {

    func testLoginNotFoundFailure() {
        self.measure {
            let result = try? repository
                .login(email: "email@notfound.com", password: "test")
                .toBlocking()
                .first()

            XCTAssertNotNil(result)
            switch result {
            case .failure(let error):
                switch error {
                case .notFound:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Unexpected result")
                }

            default:
                XCTFail("Unexpected result")
            }

        }
    }

    func testLoginBadRequestFailure() {
        self.measure {
            let result = try? repository
                .login(email: "test@test.com", password: "invalidPass")
                .toBlocking()
                .first()

            XCTAssertNotNil(result)
            switch result {
            case .failure(let error):
                switch error {
                case .badRequest:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Unexpected result")
                }

            default:
                XCTFail("Unexpected result")
            }

        }
    }

    func testLoginSuccess() {
        self.measure {
            let result = try? repository
                .login(email: "test@test.com", password: "test")
                .toBlocking()
                .first()

            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTAssertTrue(true)

            default:
                XCTFail("Unexpected result")
            }

        }
    }
}
