//
//  SKCredentialsRepository.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKCredentialsRepository {

    func find(identifier: String) -> Result<SKCredentialsEntity, SKRepositoryError>

    func save(
        identifier: String,
        email: String,
        password: String
    ) -> Result<Any, SKRepositoryError>

    func delete(identifier: String) -> Result<Any, SKRepositoryError>

}
