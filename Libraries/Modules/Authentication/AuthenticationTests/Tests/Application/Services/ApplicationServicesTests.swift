//
//  ApplicationServicesTests.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import XCTest

@testable import Authentication

class ApplicationServicesTests: XCTestCase {

    struct Assembler: ApplicationServices {/* empty */}

}

// MARK: - Tests

extension ApplicationServicesTests {

    func testApplicationServices() {
        let assembler = Assembler()
        self.measure {
            XCTAssertNotNil(assembler.auth)
        }
    }

}
