//
//  LoginServiceProvider.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxSwift

struct LoginServiceProvider {

    var logger: MFLog?
    var respository: AuthRepository

}

extension LoginServiceProvider: LoginService {

    func execute(email: String, password: String) -> Observable<Result<String, AuthError>> {
        logger?.info(classType: type(of: self), line: #line, message: "Identificating \(email)...")

        return respository
            .login(email: email, password: password)
            .flatMapLatest { result -> Observable<Result<String, AuthError>> in
                switch result {
                case .success(let entity): return .just(.success(entity.value))
                case .failure(let error):
                    switch error {
                    case .badRequest:   return .just(.failure(.invalidCredentials))
                    default:            return .just(.failure(.userNotFound))
                    }
                }
        }
    }

}
