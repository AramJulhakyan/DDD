//
//  ViewModels.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol ViewModels {/* empty */}

private extension ViewModels {

    func get() -> MFLog { return Assembler() }

    func get() -> FindAllService { return Assembler().findAll }

	func get() -> FindByIdService { return Assembler().findById }

}

extension ViewModels {

    var findMyGuestsVM: FindMyGuestsViewModel {
        return FindMyGuestsViewModelProvider(logger: get(), findAllService: get())
    }

	func guestDetailViewModel(with guestId: String) -> GuestDetailViewModel {
		GuestDetailViewModelProvider(guestId: guestId, logger: get(), findByIdService: get())
	}

}

private struct Assembler: GuestsApplicationServices, MFLog {/* empty */}
