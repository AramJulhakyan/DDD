//
//  AppDelegateCoordinatorProvider.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Authentication
import MyFoundation
import MyUIKit
import RxSwift
import System
import UIKit

final class AppDelegateCoordinatorProvider: MUKCoordinator {

    // MARK: - Dependencies

    var credentialsService: SKCredentialsService?

    var logger: MFLog?

    // MARK: - Properties

    lazy var childCoordinators: [MUKCoordinator] = []

    lazy var window: UIWindow = { .init(frame: UIScreen.main.bounds) }()

    lazy var disposeBag: DisposeBag = { .init() }()

    // MARK: - Lifecycle

    init(credentialsServices: SKCredentialsService?, logger: MFLog?) {
        self.credentialsService = credentialsServices
        self.logger             = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released.")
    }

    func start() {
//        let credentials = credentialsService?.find()
//        switch credentials {
//        case .success((let email, let password)):
//            autoLogin(email: email, password: password)
//
//        case .failure:
//            removeCredentials()
//            showLogin()
//
//        default:
//            break
//        }

        showLogin()
    }

}

// MARK: - Additional properties

extension AppDelegateCoordinatorProvider {

    func storeCredentials(email: String, password: String) {
        _ = credentialsService?.save(email: email, password: password)
    }

    func removeCredentials() {
        _ = credentialsService?.delete()
    }

    func autoLogin(email: String, password: String) {
        let autologinService = AuthenticationServices.autoLogin
        autologinService.output.drive(onNext: { [unowned self] result in
            switch result {
            case .success: self.showMain()
            case .failure: self.showLogin()
            }
        }).disposed(by: disposeBag)

        autologinService.execute(email: email, password: password)
    }

    func showLogin() {
        let instance = AuthenticationCoordinators.loginCoordinator
        instance
            .output
            .drive(onNext: { [unowned self, unowned instance] result in
                self.storeCredentials(email: result.email, password: result.password)
                self.removeChildCoordinator(instance)
                self.showMain()
            })
            .disposed(by: disposeBag)

        instance.start()

        addChildCoordinator(instance)
        makeKeyAndVisible(with: instance)
    }

    func showMain() {
        let instance = Coordinators.mainTabCoordinator
        instance
            .dismiss
            .drive(onNext: { [unowned self, unowned instance] () in
                self.removeCredentials()
                self.removeChildCoordinator(instance)
                self.showLogin()
            })
            .disposed(by: disposeBag)

        instance.start()

        addChildCoordinator(instance)
        makeKeyAndVisible(with: instance)
    }

    func makeKeyAndVisible(with coordinator: MUKRootViewCoordinator) {
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }

}
