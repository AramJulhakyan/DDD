//
//  SKUserDefaultsSettingsRepository.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct SKUserDefaultsSettingsRepository {
    let userDefaults: UserDefaults

    //swiftlint:disable superfluous_disable_command type_name
    private enum Key: String {
        case account
    }

}

extension SKUserDefaultsSettingsRepository: SKSettingsRepository {

    var account: String? {
        get { return userDefaults.string(forKey: Key.account.rawValue) }
        set {
            userDefaults.set(newValue, forKey: Key.account.rawValue)
            userDefaults.synchronize()
        }
    }

}
