//
//  LoginViewModelMock.swift
//  AuthenticationTests
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Authentication

struct LoginViewModelMock {

    var result: Result<String, AuthError> = .failure(.userNotFound)

}

extension LoginViewModelMock: LoginViewModel {

    func transform(input: LoginViewModelProvider.Input) -> LoginViewModelProvider.Output {
        let result = input
            .submit
            .flatMapLatest { () -> Observable<Result<String, AuthError>> in
                return .just(self.result)
            }
            .asDriver(onErrorJustReturn: .failure(.userNotFound))

        return LoginViewModelProvider.Output(result: result)
    }

}
