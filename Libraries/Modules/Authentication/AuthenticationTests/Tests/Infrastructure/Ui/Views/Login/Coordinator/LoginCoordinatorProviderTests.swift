//
//  LoginCoordinatorProviderTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift

@testable import Authentication

class LoginCoordinatorProviderTests: XCTestCase {

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var viewModel: LoginViewModelMock = { .init() }()

    lazy var coordinator: LoginCoordinatorProvider = { .init(loginVM: viewModel, logger: nil) }()

}

extension LoginCoordinatorProviderTests {

    func testProperties() {
        XCTAssertNotNil(coordinator.rootViewController)
        XCTAssertNotNil(coordinator.disposeBag)
        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }

    func testBindResultSuccess() {
        let expectation = self.expectation(description: "default")

        var email: String?
        var password: String?

        coordinator.output.drive(onNext: { result in
            email = result.email
            password = result.password
            expectation.fulfill()
        }).disposed(by: disposeBag)
        coordinator.bind(result: .success("test"))

        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(email)
        XCTAssertNotNil(password)
    }

}
