//
//  AuthError.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

enum AuthError: Error {

    case invalidCredentials, invalidEmail, invalidPassword
    case userNotFound

}
