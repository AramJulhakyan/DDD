//
//  SettingsCoordinatorProvider.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import UIKit

final class SettingsCoordinatorProvider: SettingsCoordinator {

    // MARK: - Interface

    lazy var viewController: SettingsViewController = {
        let instance    = SettingsViewController()
        instance.logger = logger

        return instance
    }()

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Properties

    let disposeBag = DisposeBag()

    let logoutSubject = PublishSubject<Void>()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    var logout: Driver<Void> { return logoutSubject.asDriver(onErrorJustReturn: ()) }

    // MARK: - Lifecycle

    init(logger: MFLog? = nil) {
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        binding()
    }

}

// MARK: - Additional properties

extension SettingsCoordinatorProvider {

    func binding() {
        viewController
            .logoutDidPressed
            .drive(onNext: { [unowned self] in self.presentLogoutConfirmation() })
            .disposed(by: disposeBag)
    }

    func presentLogoutConfirmation() {
        let acceptAction = UIAlertAction(
            title: "Yes",
            style: .default
        ) { [unowned self] _ in self.requestLogout() }

        let denyAction = UIAlertAction(title: "No", style: .destructive)

        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        alertController.addAction(acceptAction)
        alertController.addAction(denyAction)

        viewController.present(alertController, animated: true)
    }

    func requestLogout() {
        logoutSubject.onNext(())
    }

}
