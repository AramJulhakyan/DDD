//
//  LoginServiceMock.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Authentication

struct LoginServiceMock {

    var observable: Observable<Result<String, AuthError>>?

}

extension LoginServiceMock: LoginService {

    func execute(email: String, password: String) -> Observable<Result<String, AuthError>> {
        return observable ?? .just(.failure(.userNotFound))
    }

}
