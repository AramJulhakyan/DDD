//
//  AuthenticationViews.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

public enum AuthenticationCoordinators {

    public static var loginCoordinator: LoginCoordinator {
        return LoginCoordinatorProvider(viewController: get(), logger: get())
    }

}

private extension AuthenticationCoordinators {

    static func get() -> MFLog { return Assembler() }

    static func get() -> LoginViewController { return Assembler().loginVC }

}

private struct Assembler: MFLog, AuthenticationViews {/* empty */}
