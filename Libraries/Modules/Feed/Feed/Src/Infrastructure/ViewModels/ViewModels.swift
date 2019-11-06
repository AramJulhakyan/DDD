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

    func get() -> FindItemService { return Assembler().findItem }

    func get() -> MFLog { return Assembler() }

}

extension ViewModels {

    var feedVM: FeedViewModel { return FeedViewModelProvider(logger: get(), findAllItemsService: get()) }

    func findItemVM(with itemId: String) -> FindItemViewModel {
        FindItemViewModelProvider(itemId: itemId, logger: get(), findItemService: get())
    }

}

private struct Assembler: FeedApplicationServices, MFLog {/* empty */}
