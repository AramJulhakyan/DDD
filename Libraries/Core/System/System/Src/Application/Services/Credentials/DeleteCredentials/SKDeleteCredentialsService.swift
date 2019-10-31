//
//  SKDeleteCredentialsService.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKDeleteCredentialsService {

    func execute(identifier: String) -> Result<Any, SKCredentialsError>

}
