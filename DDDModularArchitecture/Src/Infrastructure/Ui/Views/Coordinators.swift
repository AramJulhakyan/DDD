//
//  Coordinators.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import UIKit

enum Coordinators {

    static var mainTabCoordinator: MainTabBarCoordinator {
        return MainTabBarCoordinatorProvider(logger: get())
    }

    static var settingsCoordinator: SettingsCoordinator { return SettingsCoordinatorProvider(logger: get()) }

}

private extension Coordinators {

    static func get() -> MFLog { return Assembler() }

}

private struct Assembler: MFLog {/* empty */}
