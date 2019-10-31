//
//  SKManageSettings.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct SKManageSettings {
    var repository: SKSettingsRepository
}

extension SKManageSettings: SKManageSettingsService {

    var account: String? {
        get { return repository.account }
        set { repository.account = newValue }
    }

}
