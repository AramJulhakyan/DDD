//
//  LoginViewModelProviderTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Authentication

class LoginViewModelProviderTests: XCTestCase {

    lazy var service: LoginServiceMock = { .init() }()

    lazy var viewModel: LoginViewModel = { LoginViewModelProvider(logger: nil, loginService: service) }()

}

// MARK: - Tests

extension LoginViewModelProviderTests {

    func testInvalidEmailFailure() {
        let input = LoginViewModelProvider.Input(
            email: BehaviorSubject<String>(value: "invalid email format"),
            password: BehaviorSubject<String>(value: "test"),
            submit: BehaviorSubject<Void>(value: ())
        )

        let output = viewModel.transform(input: input)

        self.measure {
            let result = try? output.result.toBlocking().first()
            XCTAssertNotNil(result)
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidEmail)
            default:
                XCTFail("Unexpected result")
            }
        }
    }

    func testInvalidPasswordFailure() {
        let input = LoginViewModelProvider.Input(
            email: BehaviorSubject<String>(value: "test@test.com"),
            password: BehaviorSubject<String>(value: "t"),
            submit: BehaviorSubject<Void>(value: ())
        )

        let output = viewModel.transform(input: input)

        self.measure {
            let result = try? output.result.toBlocking().first()
            XCTAssertNotNil(result)
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidPassword)
            default:
                XCTFail("Unexpected result")
            }
        }
    }

    func testInvalidCredentialsFailure() {
        service.observable = .just(.failure(.invalidCredentials))

        let input = LoginViewModelProvider.Input(
            email: BehaviorSubject<String>(value: "test@test.com"),
            password: BehaviorSubject<String>(value: "test"),
            submit: BehaviorSubject<Void>(value: ())
        )

        let output = viewModel.transform(input: input)

        self.measure {
            let result = try? output.result.toBlocking().first()
            XCTAssertNotNil(result)
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidCredentials)
            default:
                XCTFail("Unexpected result")
            }
        }
    }

    func testSuccess() {
        let expectedToken = "test"
        service.observable = .just(.success(expectedToken))
        let input = LoginViewModelProvider.Input(
            email: BehaviorSubject<String>(value: "test@test.com"),
            password: BehaviorSubject<String>(value: "test"),
            submit: BehaviorSubject<Void>(value: ())
        )

        let output = viewModel.transform(input: input)

        self.measure {
            let result = try? output.result.toBlocking().first()
            XCTAssertNotNil(result)
            switch result {
            case .success(let token):
                XCTAssertEqual(token, expectedToken)
            default:
                XCTFail("Unexpected result")
            }
        }
    }

}
