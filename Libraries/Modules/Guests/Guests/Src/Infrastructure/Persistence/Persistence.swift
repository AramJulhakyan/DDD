//
//  Persistence.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol Persistance {/* empty */}

extension Persistance {

    var repositories: PersistanceRepositories { return Assembler() }

}

private struct Assembler: PersistanceRepositories {/* empty */}
