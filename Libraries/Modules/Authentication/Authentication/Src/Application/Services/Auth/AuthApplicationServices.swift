//
//  AuthApplicationServices.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol AuthApplicationServices {/* empty */}

private extension AuthApplicationServices {

    func get() -> MFLog { return Assembler() }

    func get() -> AuthRepository { return Assembler().auth }

}

extension AuthApplicationServices {

    var login: LoginService { return LoginServiceProvider(logger: get(), respository: get()) }

}

private struct Assembler: MFLog, PersistanceRepositories {/* empty */}
