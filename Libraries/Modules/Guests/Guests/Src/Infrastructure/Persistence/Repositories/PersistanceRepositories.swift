//
//  PersistanceRepositories.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol PersistanceRepositories {/* empty */}

extension PersistanceRepositories {

    var guestsRepository: GuestsRepository { return HttpGuestsRepository() }

}
