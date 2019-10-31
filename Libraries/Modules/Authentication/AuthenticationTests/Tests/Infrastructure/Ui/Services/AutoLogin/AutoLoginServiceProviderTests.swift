//
//  AutoLoginServiceProviderTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Authentication

class AutoLoginServiceProviderTests: XCTestCase {

    lazy var viewModel: LoginViewModelMock = { .init() }()

    lazy var service: AutoLoginService = { AutoLoginServiceProvider(loginVM: viewModel) }()

    lazy var disposeBag: DisposeBag = { .init() }()

}

// MARK: - Tests

extension AutoLoginServiceProviderTests {

    func testExecuteFailure() {
        let expectation = self.expectation(description: "default")
        var result: Result<Bool, Error>?

        service.output.drive(onNext: { value in
            result = value
            expectation.fulfill()
        }).disposed(by: disposeBag)

        service.execute(email: "test", password: "test")

        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(result)
        switch result {
        case .failure:
            XCTAssertTrue(true)
        default:
            XCTFail("Unexpected result")
        }
    }

    func testExecuteSuccess() {
        let expectation = self.expectation(description: "default")
        var result: Result<Bool, Error>?

        viewModel.result = .success("test")
        service.output.drive(onNext: { value in
            result = value
            expectation.fulfill()
        }).disposed(by: disposeBag)

        service.execute(email: "test", password: "test")

        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(result)
        switch result {
        case .success:
            XCTAssertTrue(true)
        default:
            XCTFail("Unexpected result")
        }
    }
}
