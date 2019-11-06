//
//  GuestsViews.swift
//  Guests
//
//  Created by Toni Vecina on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol GuestsViews {/* empty */}

extension GuestsViews {

    var guestListVC: GuestListViewController {
        let instance = GuestListViewController()
        instance.logger = get()
        instance.findMyGuestsVM = get()

        return instance
    }

}

// MARK: - Dependencies

private extension GuestsViews {

    func get() -> MFLog { Assembler() }

    func get() -> FindMyGuestsViewModel { Assembler().findMyGuestsVM }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
