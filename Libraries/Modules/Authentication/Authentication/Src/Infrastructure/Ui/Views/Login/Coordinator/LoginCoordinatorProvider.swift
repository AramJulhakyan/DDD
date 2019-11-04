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
import RxSwift
import UIKit

final class LoginCoordinatorProvider: LoginCoordinator {

    // MARK: - Properties

    lazy var viewController: LoginViewController = {
        let instance    = LoginViewController()
        instance.logger = logger

        return instance
    }()

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var outputSubject = PublishSubject<Void>()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    var output: Driver<(email: String, password: String)> {
        let input = Observable.combineLatest(viewController.email, viewController.password)
        return outputSubject
            .withLatestFrom(input)
            .flatMapLatest({ (email, password) -> Observable<(email: String, password: String)> in
                return .just((email: email, password: password))
            })
            .asDriver(onErrorJustReturn: (email: "", password: ""))
    }

    // MARK: - Dependencies

    var logger: MFLog?

    var loginVM: LoginViewModel?

    // MARK: - Lifecycle

    init(loginVM: LoginViewModel?, logger: MFLog?) {
        self.loginVM    = loginVM
        self.logger     = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        bind(viewModel: loginVM)
    }

}

// MARK: - Additional properties

extension LoginCoordinatorProvider {

    func bind(viewModel: LoginViewModel?) {
        let input = LoginViewModelProvider.Input(
            email: viewController.email,
            password: viewController.password,
            submit: viewController.submitDidPressed
        )

        let output = viewModel?.transform(input: input)
        output?.result.drive(onNext: { [unowned self] result in
            self.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<String, AuthError>) {
        logger?.info(classType: type(of: self), line: #line, message: String(describing: result))
        switch result {
        case .success:              outputSubject.onNext(())
        case .failure(let error):   presentAlertError(error: error)
        }
    }

    func presentAlertError(error: AuthError) {
        let message: String
        switch error {
        case .invalidEmail:     message = "Invalid email"
        case .invalidPassword:  message = "Invalid password"
        default:                message = "Invalid credentials"
        }

        let alertAction = UIAlertAction(title: "Ok", style: .default)

        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(alertAction)

        viewController.present(alertController, animated: true)
    }

}
