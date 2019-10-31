//
//  SKServices.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

public protocol SKServices {}

private extension SKServices {

    func get() -> SKManageSettingsService { return Assembler().manageSettings }

    func get() -> SKDeleteCredentialsService { return Assembler().deleteCredentials }

    func get() -> SKFindCredentialsService { return Assembler().findCredentials }

    func get() -> SKSaveCredentialsService { return Assembler().saveCredentials }

}

public extension SKServices {

    var credentials: SKCredentialsService {
        return SKCredentials(
            manageSettingsService: get(),
            deleteCredentialsService: get(),
            findCredentialsService: get(),
            saveCredentialsService: get()
        )
    }

}

private struct Assembler: SKApplicationServices {}
