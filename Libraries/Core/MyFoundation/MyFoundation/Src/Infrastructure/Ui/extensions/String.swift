//
//  String.swift
//  MyFoundation
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

public extension String {

    /// Match email format
    ///
    /// - returns: `Bool` of match result

    var isEmail: Bool {
        return range(
            of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
            options: .regularExpression) != nil
    }

}
