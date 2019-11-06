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

    lazy var coordinator: LoginCoordinatorProvider = { .init(viewController: .init(), logger: nil) }()

}

extension LoginCoordinatorProviderTests {

    func testProperties() {
        XCTAssertNotNil(coordinator.rootViewController)
        XCTAssertTrue(coordinator.childCoordinators.isEmpty)
    }

}
