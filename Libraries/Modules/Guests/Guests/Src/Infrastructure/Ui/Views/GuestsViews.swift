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

	func guestDetailVC(guestId: String) -> GuestDetailViewController {
        let instance = GuestDetailViewController()
        instance.guestDetailViewModel = get(with: guestId)
        return instance
    }

}

// MARK: - Dependencies

private extension GuestsViews {

    func get() -> MFLog { Assembler() }

    func get() -> FindMyGuestsViewModel { Assembler().findMyGuestsVM }

	func get(with guestId: String) -> GuestDetailViewModel { Assembler().guestDetailViewModel(with: guestId) }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
