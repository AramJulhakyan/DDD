//
//  FeedViews.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit

public enum FeedCoordinators {/* empty */}

// MARK: - Private coordinators

extension FeedCoordinators {

    static func findItemCoordinator(itemId: String) -> FeedItemCoordinator {
        FeedItemCoordinatorProvider(viewController: get(itemId: itemId), logger: get())
    }

}

// MARK: - Public coordinators

public extension FeedCoordinators {

    static var feedCoordinator: FeedCoordinator {
        FeedCoordinatorProvider(viewController: get(), logger: get())
    }

}

// MARK: - Dependencies

private extension FeedCoordinators {

    static func get() -> MFLog { Assembler() }

    static func get() -> FeedViewController { Assembler().feedVC }

    static func get(itemId: String) -> FeedItemViewController { Assembler().feedItemVC(itemId: itemId) }

}

private struct Assembler: MFLog, FeedViews {/* empty */}
