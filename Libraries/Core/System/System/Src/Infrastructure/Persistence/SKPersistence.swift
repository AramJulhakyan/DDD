//
//  SKPersistence.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKPersistence {}

private extension SKPersistence {

    func get() -> SKLog { return Assembler() }

}

extension SKPersistence {

    var credentialsRepository: SKCredentialsRepository {
        return SKKeychainCredentialsRepository(logger: get())
    }

    var settingsRepository: SKSettingsRepository {
        return SKUserDefaultsSettingsRepository(userDefaults: UserDefaults.standard)
    }

}

private struct Assembler: SKLog {}
