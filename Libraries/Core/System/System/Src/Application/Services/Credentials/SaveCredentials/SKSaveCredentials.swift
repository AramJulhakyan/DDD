//
//  SKSaveCredentials.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct SKSaveCredentials {
    let repository: SKCredentialsRepository
    let logger: SKLog?

    init(repository: SKCredentialsRepository, logger: SKLog? = nil) {
        self.repository = repository
        self.logger     = logger
    }

}

extension SKSaveCredentials: SKSaveCredentialsService {

    func execute(
        identifier: String,
        email: String,
        password: String
    ) -> Result<Any, SKCredentialsError> {
        logger?.info(classType: type(of: self), line: #line, message: "Saving credentials for \(identifier)...")

        let response = repository.save(identifier: identifier, email: email, password: password)
        switch response {
        case .success:
            return Result.success(true)

        case .failure(let repositoryError):
            self.logger?.info(classType: type(of: self), line: #line, data: repositoryError)
            switch repositoryError {
            case .fail(let code, _, _) where 400...499 ~= code:
                return Result.failure(.notSaved(error: repositoryError))
            default:
                return Result.failure(.unknown(error: repositoryError))
            }
        }
    }

}
