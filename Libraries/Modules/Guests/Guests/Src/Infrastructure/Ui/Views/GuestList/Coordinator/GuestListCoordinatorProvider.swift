//
//  GuestListCoordinatorProvider.swift
//  Guests
//
//  Created by Toni Vecina on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxSwift

final class GuestListCoordinatorProvider: GuestListCoordinator {

    // MARK: - Properties

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    // MARK: - Dependencies

    private var logger: MFLog?

    private var viewController: GuestListViewController?

    // MARK: - Lifecycle

    init(viewController: GuestListViewController?, logger: MFLog?) {
        self.viewController = viewController
        self.logger         = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {/* empty */}

}

// MARK: - Additional properties

extension GuestListCoordinatorProvider {

    func prepareInterface() {
        // ViewController outputs configurations here
    }

}
