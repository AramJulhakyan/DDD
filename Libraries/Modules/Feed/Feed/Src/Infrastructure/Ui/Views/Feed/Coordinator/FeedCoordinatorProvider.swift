//
//  FeedCoordinatorProvider.swift
//  Feed
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import UIKit

final class FeedCoordinatorProvider: FeedCoordinator {

    // MARK: - Properties

    private lazy var disposeBag: DisposeBag = { .init() }()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    // MARK: - Dependencies

    private let logger: MFLog?

    private let viewController: FeedViewController

    // MARK: - Lifecycle

    init(viewController: FeedViewController, logger: MFLog?) {
        self.viewController = viewController
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        bind()
    }

}

// MARK: - Additional properties

private extension FeedCoordinatorProvider {

    func bind() {
        viewController.itemDidSelect.drive(onNext: { [weak self] itemId in
            self?.presentDetailView(for: itemId)
        }).disposed(by: disposeBag)
    }

    func presentDetailView(for itemId: String) {
        let findItemCoordinator = FeedCoordinators.findItemCoordinator(itemId: itemId)
        guard let rootViewController = findItemCoordinator.rootViewController else { return }
        findItemCoordinator.start()
        addChildCoordinator(findItemCoordinator)

        findItemCoordinator.didDismiss.drive(onNext: { [weak self, unowned findItemCoordinator] in
            self?.removeChildCoordinator(findItemCoordinator)
        }).disposed(by: disposeBag)

        viewController.navigationController?.pushViewController(rootViewController, animated: true)
    }

}
