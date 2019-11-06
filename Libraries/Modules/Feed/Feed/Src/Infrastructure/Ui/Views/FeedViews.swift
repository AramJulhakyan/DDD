//
//  FeedViews.swift
//  Feed
//
//  Created by Toni Vecina on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol FeedViews {/* empty */}

extension FeedViews {

    var feedVC: FeedViewController {
        let instance = FeedViewController()
        instance.logger = get()
        instance.viewModel = get()

        return instance
    }

    func feedItemVC(itemId: String) -> FeedItemViewController {
        let instance = FeedItemViewController()
        instance.logger = get()
        instance.findItemVM = get(with: itemId)

        return instance
    }
}

// MARK: - Dependencies

private extension FeedViews {

    func get() -> MFLog { Assembler() }

    func get() -> FeedViewModel { Assembler().feedVM }

    func get(with itemId: String) -> FindItemViewModel { Assembler().findItemVM(with: itemId) }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
