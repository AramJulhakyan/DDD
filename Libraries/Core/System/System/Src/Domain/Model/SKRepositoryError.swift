//
//  SKRepositoryError.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

enum SKRepositoryError: Error {

    case fail(code: Int, detail: String, error: Error?)

}
