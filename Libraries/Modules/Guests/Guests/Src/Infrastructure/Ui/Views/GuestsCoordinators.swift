//
//  GuestsViews.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit

public enum GuestsCoordinators {

    public static var guestListCoordinator: MUKRootViewCoordinator {
        return GuestListCoordinatorProvider(findMyGuestsVM: get(), logger: get())
    }

}

private extension GuestsCoordinators {

    static func get() -> FindMyGuestsViewModel { return Assembler().findMyGuestsVM }

    static func get() -> MFLog { return Assembler() }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
