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

    lazy var tokenSubject: PublishSubject<(email: String, password: String)> = { .init() }()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    var output: Driver<(email: String, password: String)> {
        return tokenSubject.asDriver(onErrorJustReturn: (email: "", password: ""))
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
            email: viewController.emailTextField.rx.text.orEmpty.asObservable(),
            password: viewController.passwordTextField.rx.text.orEmpty.asObservable(),
            submit: viewController.submitButton.rx.tap.asObservable()
        )

        let output = viewModel?.transform(input: input)
        output?.result.drive(onNext: { [unowned self] result in
            self.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<String, AuthError>) {
        logger?.info(classType: type(of: self), line: #line, message: String(describing: result))
        switch result {
        case .success(let token): output(with: token)
        case .failure(let error): presentAlertError(error: error)
        }
    }

    func presentAlertError(error: AuthError) {
        let message: String
        switch error {
        case .invalidEmail:     message = "Invalid email"
        case .invalidPassword:  message = "Invalid password"
        default:                message = "Invalid credentials"
        }

        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(alertAction)

        viewController.present(alertController, animated: true, completion: nil)
    }

    func output(with token: String) {
        tokenSubject.onNext((
            email: viewController.emailTextField.text ?? "",
            password: viewController.passwordTextField.text ?? ""
        ))
    }

}
