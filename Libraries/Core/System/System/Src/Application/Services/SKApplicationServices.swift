//
//  SKApplicationServices.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol SKApplicationServices {}

private extension SKApplicationServices {

    func get() -> SKLog { return Assembler() }

    func get() -> SKCredentialsRepository { return Assembler().credentialsRepository }

    func get() -> SKSettingsRepository { return Assembler().settingsRepository }

}

// MARK: - Settings

extension SKApplicationServices {

    var manageSettings: SKManageSettingsService { return SKManageSettings(repository: get()) }

}

// MARK: - Credentials

extension SKApplicationServices {

    var deleteCredentials: SKDeleteCredentialsService {
        return SKDeleteCredentials(repository: get(), logger: get())
    }

    var findCredentials: SKFindCredentialsService {
        return SKFindCredentials(repository: get(), logger: get())
    }

    var saveCredentials: SKSaveCredentialsService {
        return SKSaveCredentials(repository: get(), logger: get())
    }

}

private struct Assembler: SKPersistence, SKLog {}
