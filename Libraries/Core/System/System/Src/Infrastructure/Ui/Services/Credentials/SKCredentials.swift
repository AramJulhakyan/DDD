//
//  SKCredentials.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

final class SKCredentials {
    var manageSettingsService: SKManageSettingsService

    let deleteCredentialsService: SKDeleteCredentialsService
    let findCredentialsService: SKFindCredentialsService
    let saveCredentialsService: SKSaveCredentialsService

    required init(
        manageSettingsService: SKManageSettingsService,
        deleteCredentialsService: SKDeleteCredentialsService,
        findCredentialsService: SKFindCredentialsService,
        saveCredentialsService: SKSaveCredentialsService
    ) {
        self.manageSettingsService      = manageSettingsService
        self.deleteCredentialsService   = deleteCredentialsService
        self.findCredentialsService     = findCredentialsService
        self.saveCredentialsService     = saveCredentialsService
    }
}

extension SKCredentials: SKCredentialsService {

    func delete() -> Result<Any, Error> {
        guard let account = manageSettingsService.account else { return Result.success(true) }

        let response = deleteCredentialsService.execute(identifier: account)
        switch response {
        case .success:
            self.manageSettingsService.account = nil
            return Result.success(true)

        case .failure(let error):
            return Result.failure(error)
        }
    }

    func find() -> Result<(email: String, password: String), Error> {
        guard let account = manageSettingsService.account else {
            let error = NSError(domain: "Credentials not found", code: 404, userInfo: nil)
            return Result.failure(error)
        }

        let response = findCredentialsService.execute(identifier: account)
        switch response {
        case .success(let email, let password):
            let account = (email: email, password: password)
            return Result.success(account)

        case .failure(let error):
            return Result.failure(error)
        }
    }

    func save(email: String, password: String) -> Result<Any, Error> {
        let identifier = UUID().uuidString

        let response = saveCredentialsService.execute(
            identifier: identifier,
            email: email,
            password: password
        )

        switch response {
        case .success:
            self.manageSettingsService.account = identifier
            return Result.success(true)

        case .failure(let error):
            _ = self.deleteCredentialsService.execute(identifier: identifier)
            self.manageSettingsService.account = nil
            return Result.failure(error)
        }
    }

}
