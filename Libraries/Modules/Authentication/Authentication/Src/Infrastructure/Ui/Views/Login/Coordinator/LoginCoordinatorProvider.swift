//
//  LoginCoordinatorProvider.swift
//  Authentication
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import UIKit

final class LoginCoordinatorProvider: LoginCoordinator {

    // MARK: - Properties

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    // MARK: - Dependencies

    private var logger: MFLog?

    private var viewController: LoginViewController

    // MARK: - Lifecycle

    init(viewController: LoginViewController, logger: MFLog?) {
        self.viewController = viewController
        self.logger         = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {/* empty */}

}

// MARK: - Additional properties

extension LoginCoordinatorProvider {

    var output: Driver<(email: String, password: String)> { viewController.output }

}
