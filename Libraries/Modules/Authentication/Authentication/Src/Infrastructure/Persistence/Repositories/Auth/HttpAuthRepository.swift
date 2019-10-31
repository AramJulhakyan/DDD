//
//  HttpAuthRepository.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

struct HttpAuthRepository {

    // Place for 'HttpClient' dependency

}

extension HttpAuthRepository: AuthRepository {

    // Mocked response

    func login(email: String, password: String) -> Observable<Result<UserTokenEntity, DomainError>> {
        guard email.lowercased(with: nil) == "test@test.com" else {
            return .just(.failure(.notFound(message: "Email not found")))
        }

        guard password == "test" else {
            return .just(.failure(.badRequest(message: "Password not found")))
        }

        return .just(.success(UserTokenEntity(value: UUID().uuidString)))
    }

}
