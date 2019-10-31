//
//  SKKeychainCredentialsRepository.swift
//  System
//
//  Created by Toni Vecina on 30/05/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import Security

struct SKKeychainCredentialsRepository {
    let logger: SKLog?

    init(logger: SKLog? = nil) {
        self.logger = logger
    }

}

extension SKKeychainCredentialsRepository: SKCredentialsRepository {

    func find(identifier: String) -> Result<SKCredentialsEntity, SKRepositoryError> {
        logger?.info(
            classType: type(of: self),
            line: #line,
            message: "Getting credentials from Keychain for \(identifier)..."
        )

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrLabel as String: identifier,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status != errSecItemNotFound else {
            return Result.failure(.fail(code: 404, detail: "Password not found", error: nil))
        }

        guard status == errSecSuccess else {
            return Result.failure(.fail(code: 400, detail: "Credentials not found", error: nil))
        }

        guard let existingItem = item as? [String: Any],
            let email = existingItem[kSecAttrAccount as String] as? String,
            let data = existingItem[kSecValueData as String] as? Data,
            let password = String(data: data, encoding: .utf8)
            else {
                return Result.failure(.fail(code: 400, detail: "Password cannot be decoded", error: nil))
        }

        let entity = SKKeychainCredentialsEntity(identifier: identifier, email: email, password: password)
        return Result.success(entity)
    }

    func save(
        identifier: String,
        email: String,
        password: String
    ) -> Result<Any, SKRepositoryError> {
        logger?.info(
            classType: type(of: self),
            line: #line,
            message: "Saving credentials in Keychain for \(identifier)..."
        )

        guard let passwordEncoded = password.data(using: .utf8) else {
            return Result.failure(.fail(code: 500, detail: "Password not encoded", error: nil))
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrLabel as String: identifier,
            kSecAttrAccount as String: email,
            kSecValueData as String: passwordEncoded
        ]

        var status = SecItemAdd(query as CFDictionary, nil)

        switch status {
        case errSecDuplicateItem:
            status = SecItemDelete([kSecClass as String: kSecClassGenericPassword] as CFDictionary)
        default:
            break
        }

        guard status == errSecSuccess else {
            return Result.failure(.fail(
                code: 400,
                detail: "Credentials not saved",
                error: NSError(domain: String(describing: status), code: 401, userInfo: nil)
                )
            )
        }

        return Result.success(true)
    }

    func delete(identifier: String) -> Result<Any, SKRepositoryError> {
        logger?.info(
            classType: type(of: self),
            line: #line,
            message: "Deleting credentials from Keychain for \(identifier)...")

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrLabel as String: identifier
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return Result.failure(.fail(code: 400, detail: "Credentials not deleted", error: nil))
        }

        return Result.success(true)
    }

}
