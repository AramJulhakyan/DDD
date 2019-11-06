//
//  LoginViewController.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Interface

    private lazy var emailTextField: UITextField = {
        let instance                    = UITextField()
        instance.placeholder            = "your@email.com"
        instance.keyboardType           = .emailAddress
        instance.autocapitalizationType = .none
        instance.clearButtonMode        = .whileEditing

        return instance
    }()

    private lazy var passwordTextField: UITextField = {
        let instance = UITextField()
        instance.placeholder        = "password"
        instance.keyboardType       = .default
        instance.isSecureTextEntry  = true
        instance.clearButtonMode    = .whileEditing

        return instance
    }()

    private lazy var submitButton: UIButton = {
        let instance = UIButton()
        instance.setTitle("Login", for: .normal)
        instance.backgroundColor = .darkText

        return instance
    }()

    private lazy var formStackView: UIStackView = {
        let instance        = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, submitButton])
        instance.axis       = .vertical
        instance.alignment  = .fill
        instance.spacing    = 24.0

        return instance
    }()

    // MARK: - Properties

    private lazy var disposeBag: DisposeBag = { .init() }()

    private lazy var outputSubject: PublishSubject<(email: String, password: String)> = { .init() }()

    // MARK: - Dependencies

    var logger: MFLog?

    var loginVM: LoginViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInteface()
        prepareLayouts()

        bind(viewModel: loginVM)
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}

// MARK: - Additional properties

extension LoginViewController {

    var output: Driver<(email: String, password: String)> {
        outputSubject.asDriver(onErrorJustReturn: (email: "", password: ""))
    }

    func prepareInteface() {
        view.backgroundColor = .white
        view.addSubview(formStackView)
    }

    func prepareLayouts() {
        formStackView.snp.makeConstraints { make in
            let inset = UIEdgeInsets(top: .zero, left: 24, bottom: .zero, right: 24)
            make.left.right.equalToSuperview().inset(inset)
            make.center.equalToSuperview()
        }
    }

    func bind(viewModel: LoginViewModel?) {
        let input = LoginViewModelProvider.Input(
            email: emailTextField.rx.value.orEmpty.asObservable(),
            password: passwordTextField.rx.value.orEmpty.asObservable(),
            submit: submitButton.rx.tap.asObservable()
        )

        let output = viewModel?.transform(input: input)
        output?.result.drive(onNext: { [unowned self] result in
            self.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<String, AuthError>) {
        logger?.info(classType: type(of: self), line: #line, message: String(describing: result))
        switch result {
        case .success:              outputUserLogged()
        case .failure(let error):   presentAlertError(error: error)
        }
    }

    func outputUserLogged() {
        outputSubject.onNext((
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        ))
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

        present(alertController, animated: true)
    }

}
