//
//  SKDeleteCredentials.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct SKDeleteCredentials {
    let repository: SKCredentialsRepository
    let logger: SKLog?

    init(repository: SKCredentialsRepository, logger: SKLog? = nil) {
        self.repository = repository
        self.logger     = logger
    }

}

extension SKDeleteCredentials: SKDeleteCredentialsService {

    func execute(identifier: String) -> Result<Any, SKCredentialsError> {
        logger?.info(classType: type(of: self), line: #line, message: "Deleting credentials for \(identifier)...")

        let response = repository.delete(identifier: identifier)
        switch response {
        case .success:
            return Result.success(true)

        case .failure(let repositoryError):
            self.logger?.info(classType: type(of: self), line: #line, data: repositoryError)
            return Result.failure(.notDeleted(error: repositoryError))
        }
    }

}
