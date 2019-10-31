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
        return LoginCoordinatorProvider(loginVM: get(), logger: get())
    }

}

private extension AuthenticationCoordinators {

    static func get() -> MFLog { return Assembler() }

    static func get() -> LoginViewModel { return Assembler().loginVM }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
