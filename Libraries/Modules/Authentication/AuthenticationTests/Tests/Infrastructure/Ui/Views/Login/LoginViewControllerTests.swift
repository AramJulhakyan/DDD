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

    lazy var viewModel: LoginViewModelMock = { .init() }()

    lazy var viewController: LoginViewController = {
        let instance        = LoginViewController()
        instance.loginVM    = viewModel

        return instance
    }()

    lazy var disposeBag: DisposeBag = { .init() }()

}

// MARK: - Tests

extension LoginViewControllerTests {

    func testTryingLoginOutput() {
        let expectation = self.expectation(description: "default")

        var emailExpec: String?
        var passwordExpec: String?

        viewModel.result = .success("test")
        viewController.viewDidLoad()

        viewController.emailTextField.text = "email"
        viewController.passwordTextField.text = "password"

        viewController.output.drive(onNext: { (arguments) in
            let (email, password)   = arguments
            emailExpec              = email
            passwordExpec           = password
            expectation.fulfill()
        }).disposed(by: disposeBag)

        viewController.output(with: "test")

        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(emailExpec)
        XCTAssertEqual(emailExpec, viewController.emailTextField.text)
        XCTAssertNotNil(passwordExpec)
        XCTAssertEqual(passwordExpec, viewController.passwordTextField.text)
    }

}
