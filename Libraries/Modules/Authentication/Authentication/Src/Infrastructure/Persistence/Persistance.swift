//
//  Persistance.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

protocol Persistance {/* empty */}

extension Persistance {

    var repositories: PersistanceRepositories { return Assembler() }

}

private struct Assembler: PersistanceRepositories {/* empty */}
