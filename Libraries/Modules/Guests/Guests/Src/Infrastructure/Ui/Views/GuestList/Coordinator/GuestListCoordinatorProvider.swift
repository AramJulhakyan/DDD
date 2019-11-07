//
//  GuestListCoordinatorProvider.swift
//  Guests
//
//  Created by Toni Vecina on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import UIKit
import RxSwift
import RxCocoa

final class GuestListCoordinatorProvider: GuestListCoordinator {

    // MARK: - Properties

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

	private let disposeBag = DisposeBag()

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

    func start() {
        bind()
    }
}

// MARK: - Additional properties

extension GuestListCoordinatorProvider {

    func bind() {
        // ViewController outputs configurations here
		viewController?.didSelectGuest
			.drive(onNext: { [weak self] idGuest in
				guard let guestId = idGuest else { return }
				self?.showGuestDetail(guestId)
			})
			.disposed(by: disposeBag)
    }

	private func showGuestDetail(_ guestId: String) {
		let guestDetailCoordinator = GuestsCoordinators.guestDetailCoordinator(guestId: guestId)
		guard let detailViewController = guestDetailCoordinator.rootViewController else { return }

		self.addChildCoordinator(guestDetailCoordinator)
		guestDetailCoordinator.detailDidClose
			.drive(onNext: { [weak self, unowned detailViewController, unowned guestDetailCoordinator] in
                detailViewController.dismiss(animated: true) {
					self?.removeChildCoordinator(guestDetailCoordinator)
				}
			})
			.disposed(by: disposeBag)
		rootViewController?.present(detailViewController, animated: true)
        guestDetailCoordinator.start()
	}
}
