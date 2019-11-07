//
//  GuestsApplicationServices.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol GuestsApplicationServices {/* empty */}

private extension GuestsApplicationServices {

    func get() -> MFLog { return Assembler() }

    func get() -> GuestsRepository { return Assembler().guestsRepository }

}

extension GuestsApplicationServices {

    var findAll: FindAllService { return FindAllServiceProvider(logger: get(), repository: get()) }

	var findById: FindByIdService { return FindByIdServiceProvider (logger: get(), repository: get()) }

}

private struct Assembler: MFLog, PersistanceRepositories {/* empty */}
