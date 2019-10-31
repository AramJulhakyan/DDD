//
//  LoginServiceProviderTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxBlocking

@testable import Authentication

class LoginServiceProviderTests: XCTestCase {

    lazy var repository: AuthRepositoryMock = { .init() }()

    lazy var service: LoginService = { LoginServiceProvider(logger: nil, respository: repository) }()

}

// MARK: - Tests

extension LoginServiceProviderTests {

    func testExecuteUserNotFoundFailure() {
        repository.observable = .just(.failure(.server(code: 500, message: "Test")))
        self.measure {
            let result = try? service.execute(email: "test", password: "test").toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .userNotFound)

            default:
                XCTFail("Unexpected response")
            }
        }
    }

    func testExecuteInvalidCredentialsFailure() {
        repository.observable = .just(.failure(.badRequest(message: "Test")))
        self.measure {
            let result = try? service.execute(email: "test", password: "test").toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)

            default:
                XCTFail("Unexpected response")
            }
        }
    }

    func testExecuteSuccess() {
        let entity = UserTokenEntity(value: "test")
        repository.observable = .just(.success(entity))
        self.measure {
            let result = try? service.execute(email: "test", password: "test").toBlocking().first()
            XCTAssertNotNil(result)

            switch result {
            case .success(let token):
                XCTAssertEqual(token, entity.value)

            default:
                XCTFail("Unexpected response")
            }
        }
    }

}
