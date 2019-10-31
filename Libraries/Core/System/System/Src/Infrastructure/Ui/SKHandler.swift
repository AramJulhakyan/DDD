//
//  SKHandler.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

public typealias SKHandler<DataType, ErrorType: Error> = (Result<DataType, ErrorType>) -> Void
