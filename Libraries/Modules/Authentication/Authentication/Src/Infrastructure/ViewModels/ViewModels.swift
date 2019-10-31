//
//  ViewModels.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol ViewModels {/* empty */}

private extension ViewModels {

    func get() -> MFLog { return Assembler() }

    func get() -> LoginService { return Assembler().login }

}

extension ViewModels {

    var loginVM: LoginViewModel { return LoginViewModelProvider(logger: get(), loginService: get()) }

}

private struct Assembler: AuthApplicationServices, MFLog {/* empty */}
