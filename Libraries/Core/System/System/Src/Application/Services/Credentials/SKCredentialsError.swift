//
//  SKCredentialsError.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

enum SKCredentialsError: Error {

    case notDeleted(error: Error?)

    case notFound(error: Error?)

    case notMatched(error: Error?)

    case notSaved(error: Error?)

    case unknown(error: Error?)

}
