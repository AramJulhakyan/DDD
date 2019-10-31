//
//  DomainError.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

enum DomainError: Error {

    case badRequest(message: String)

    case notFound(message: String)

    case server(code: Int, message: String)

}
