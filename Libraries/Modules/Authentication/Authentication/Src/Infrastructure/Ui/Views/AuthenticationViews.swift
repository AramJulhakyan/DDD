//
//  AuthenticationViews.swift
//  Authentication
//
//  Created by Toni Vecina on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol AuthenticationViews {/* empty */}

extension AuthenticationViews {

    var loginVC: LoginViewController {
        let instance = LoginViewController()
        instance.logger = get()
        instance.loginVM = get()

        return instance
    }

}

// MARK: - Dependencies

private extension AuthenticationViews {

    func get() -> MFLog { Assembler() }

    func get() -> LoginViewModel { Assembler().loginVM }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
