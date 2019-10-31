//
//  LoginViewModelProvider.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

struct LoginViewModelProvider {

    var logger: MFLog?
    var loginService: LoginService

}

extension LoginViewModelProvider {

    struct Input {
        let email: Observable<String>
        let password: Observable<String>
        let submit: Observable<Void>
    }

    struct Output {
        let result: Driver<Result<String, AuthError>>
    }

}

extension LoginViewModelProvider: LoginViewModel {

    func transform(input: Input) -> Output {
        logger?.info(classType: type(of: self), line: #line, message: "Transforming ViewModel...")
        let data = Observable.combineLatest(input.email, input.password)
        let result = input
            .submit
            .withLatestFrom(data)
            .flatMapLatest { email, password -> Observable<Result<String, AuthError>> in
                guard email.isEmail else { return .just(.failure(.invalidEmail)) }
                guard password.count > 3 else { return .just(.failure(.invalidPassword)) }

                return self.loginService.execute(email: email, password: password)
            }
            .asDriver(onErrorJustReturn: .failure(.userNotFound))

        return Output(result: result)
    }

}
