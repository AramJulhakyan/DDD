//
//  SKCredentialsEntity.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKCredentialsEntity {

    var identifier: String { get }

    var email: String { get }

    var password: String { get }

}
