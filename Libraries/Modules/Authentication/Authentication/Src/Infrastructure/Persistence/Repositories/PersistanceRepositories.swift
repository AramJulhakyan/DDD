//
//  PersistanceRepositories.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol PersistanceRepositories {/* empty */}

extension PersistanceRepositories {

    var auth: AuthRepository { return HttpAuthRepository() }

}
