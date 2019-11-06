//
//  LoginViewControllerTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift

@testable import Authentication

class LoginViewControllerTests: XCTestCase {

    lazy var viewController: LoginViewController = { .init() }()

    lazy var disposeBag: DisposeBag = { .init() }()

}

// MARK: - Tests

extension LoginViewControllerTests {

    func testPrepareInterface() {
        viewController.viewDidLoad()

        let contentStackView = viewController.view.subviews.filter { view -> Bool in
            return view is UIStackView
        }

        XCTAssertFalse(contentStackView.isEmpty)
    }

    func testBindResultSuccess() {
        let expectation = self.expectation(description: "default")

        var email: String?
        var password: String?

        viewController.output.drive(onNext: { result in
            email = result.email
            password = result.password
            expectation.fulfill()
        }).disposed(by: disposeBag)
        viewController.bind(result: .success("test"))

        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(email)
        XCTAssertNotNil(password)
    }

}
