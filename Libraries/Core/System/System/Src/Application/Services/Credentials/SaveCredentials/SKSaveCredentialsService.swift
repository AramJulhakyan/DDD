//
//  SKSaveCredentialsService.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKSaveCredentialsService {

    func execute(
        identifier: String,
        email: String,
        password: String
    ) -> Result<Any, SKCredentialsError>

}
