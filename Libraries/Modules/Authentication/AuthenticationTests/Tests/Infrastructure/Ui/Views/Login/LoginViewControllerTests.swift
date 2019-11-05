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

}
