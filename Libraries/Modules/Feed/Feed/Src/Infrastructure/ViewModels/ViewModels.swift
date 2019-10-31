//
//  ViewModels.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol ViewModels {/* empty */}

private extension ViewModels {

    func get() -> FindAllItemsService { return Assembler().findAllItems }

    func get() -> MFLog { return Assembler() }

}

extension ViewModels {

    var feedVM: FeedViewModel { return FeedViewModelProvider(logger: get(), findAllItemsService: get()) }

}

private struct Assembler: FeedApplicationServices, MFLog {/* empty */}
