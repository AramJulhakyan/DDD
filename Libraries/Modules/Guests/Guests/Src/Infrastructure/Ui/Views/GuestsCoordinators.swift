//
//  GuestsViews.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit

public enum GuestsCoordinators {/* empty */}

// MARK: - Public coordinators

public extension GuestsCoordinators {

    static var guestListCoordinator: GuestListCoordinator {
        GuestListCoordinatorProvider(viewController: get(), logger: get())
    }

}

// MARK: - Dependencies

private extension GuestsCoordinators {

    static func get() -> GuestListViewController { Assembler().guestListVC }

    static func get() -> MFLog { Assembler() }

}

private struct Assembler: MFLog, GuestsViews {/* empty */}
