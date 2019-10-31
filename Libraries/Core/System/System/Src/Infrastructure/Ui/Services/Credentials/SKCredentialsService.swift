//
//  SKCredentialsService.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

public protocol SKCredentialsService {

    func delete() -> Result<Any, Error>

    func find() -> Result<(email: String, password: String), Error>

    func save(email: String, password: String) -> Result<Any, Error>

}
