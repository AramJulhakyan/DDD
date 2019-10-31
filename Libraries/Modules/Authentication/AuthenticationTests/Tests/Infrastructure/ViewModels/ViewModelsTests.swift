//
//  ViewModelsTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class ViewModelsTests: XCTestCase {

    struct Assembler: ViewModels {/* empty */}

}

// MARK: - Tests

extension ViewModelsTests {

    func testViewModels() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.loginVM)
        }
    }

}
