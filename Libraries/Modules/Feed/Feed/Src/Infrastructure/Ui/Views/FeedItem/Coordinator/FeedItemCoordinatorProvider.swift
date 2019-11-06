//
//  FeedItemCoordinatorProvider.swift
//  Feed
//
//  Created by Miguel Angel on 04/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import UIKit

final class FeedItemCoordinatorProvider: FeedItemCoordinator {

    // MARK: Properties

    var rootViewController: UIViewController? { return viewController }

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    // MARK: - Dependencies

    private let logger: MFLog?

    private let viewController: FeedItemViewController

    // MARK: - Lifecycle

    init(viewController: FeedItemViewController, logger: MFLog?) {
        self.viewController = viewController
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {/* empty */}

}

// MARK: - Additional properties

extension FeedItemCoordinatorProvider {

    var didDismiss: Driver<Void> { viewController.didDismiss }

}
