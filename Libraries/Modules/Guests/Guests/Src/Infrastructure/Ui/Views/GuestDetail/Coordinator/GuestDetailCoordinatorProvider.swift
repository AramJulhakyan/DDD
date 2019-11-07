//
//  GuestDetailCoordinatorProvider.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import MyFoundation
import MyUIKit
import UIKit
import RxSwift
import RxCocoa

final class GuestDetailCoordinatorProvider: GuestDetailCoordinator {

    // MARK: - Properties

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

	var detailDidClose: Driver<Void> {
		return closeSubject.asDriver(onErrorJustReturn: ())
	}

	private let closeSubject = PublishSubject<Void>()

	private let disposeBag = DisposeBag()

    // MARK: - Dependencies

    private var logger: MFLog?

    private var viewController: GuestDetailViewController?

    // MARK: - Lifecycle

    init(viewController: GuestDetailViewController?, logger: MFLog?) {
        self.viewController = viewController
        self.logger         = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        setupBindings()
    }

}

// MARK: - Additional properties

extension GuestDetailCoordinatorProvider {

    func setupBindings() {
        // ViewController outputs configurations here
		viewController?.didTapClose
			.drive(closeSubject)
			.disposed(by: disposeBag)
    }

}
