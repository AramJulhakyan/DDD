//
//  Infrastructure.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import System

enum Infrastructure {

    static var appCoordinator: MUKCoordinator {
        return AppDelegateCoordinatorProvider(credentialsServices: get(), logger: get())
    }

}

private extension Infrastructure {

    static func get() -> MFLog { return Assembler() }

    static func get() -> SKCredentialsService { return Assembler().credentials }

}

private struct Assembler: MFLog, SKServices {/* empty */}
