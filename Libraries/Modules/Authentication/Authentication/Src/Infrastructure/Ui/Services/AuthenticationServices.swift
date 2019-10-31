//
//  AuthenticationServices.swift
//  Authentication
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

public enum AuthenticationServices {/* empty */}

private extension AuthenticationServices {

    static func get() -> MFLog { return Assembler() }

    static func get() -> LoginViewModel { return Assembler().loginVM }

}

public extension AuthenticationServices {

    static var autoLogin: AutoLoginService { return AutoLoginServiceProvider(logger: get(), loginVM: get()) }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
