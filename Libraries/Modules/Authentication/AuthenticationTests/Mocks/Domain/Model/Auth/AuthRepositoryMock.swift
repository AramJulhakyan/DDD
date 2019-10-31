//
//  AuthRepositoryMock.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Authentication

struct AuthRepositoryMock {

    var observable: Observable<Result<UserTokenEntity, DomainError>>?

}

extension AuthRepositoryMock: AuthRepository {

    func login(email: String, password: String) -> Observable<Result<UserTokenEntity, DomainError>> {
        return observable ?? .just(.failure(.badRequest(message: "Mock error")))
    }

}
