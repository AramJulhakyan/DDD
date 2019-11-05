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

    static var findItemCoordinator: FindItemCoordinator {
        return FindItemCoordinatorProvider(findItemVM: get(), logger: get())
    }

}

// MARK: - Public coordinators

public extension FeedCoordinators {

    static var feedCoordinator: MUKRootViewCoordinator {
        return FeedCoordinatorProvider(feedVM: get(), logger: get())
    }

}

// MARK: - Dependencies

private extension FeedCoordinators {

    static func get() -> MFLog { return Assembler() }

    static func get() -> FeedViewModel { return Assembler().feedVM }

    static func get() -> FindItemViewModel { return Assembler().findItemVM }

}

private struct Assembler: MFLog, ViewModels {/* empty */}
