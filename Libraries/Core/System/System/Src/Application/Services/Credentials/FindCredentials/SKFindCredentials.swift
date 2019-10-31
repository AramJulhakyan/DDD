//
//  SKFindCredentials.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct SKFindCredentials {
    let repository: SKCredentialsRepository
    let logger: SKLog?

    init(repository: SKCredentialsRepository, logger: SKLog? = nil) {
        self.repository = repository
        self.logger     = logger
    }

}

extension SKFindCredentials: SKFindCredentialsService {

    func execute(identifier: String) -> Result<(email: String, password: String), SKCredentialsError> {
        logger?.info(classType: type(of: self), line: #line, message: "Getting credentials for \(identifier)...")

        let response = repository.find(identifier: identifier)
        switch response {
        case .success(let entity):
            let account = (entity.email, entity.password)
            return Result.success(account)

        case .failure(let repositoryError):
            self.logger?.info(classType: type(of: self), line: #line, data: repositoryError)
            switch repositoryError {
            case .fail(let code, _, _) where 404 ~= code:
                return Result.failure(.notFound(error: repositoryError))

            case .fail(let code, _, _) where 400...499 ~= code:
                return Result.failure(.notMatched(error: repositoryError))

            default:
                return Result.failure(.unknown(error: repositoryError))
            }
        }
    }

}
