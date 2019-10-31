//
//  DomainError.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

enum DomainError: Error {

    case badRequest(message: String)

    case notFound(message: String)

    case server(code: Int, message: String)

}
