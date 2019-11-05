//
//  LoginViewController.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
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

    var email: Observable<String> { return emailTextField.rx.value.orEmpty.asObservable() }

    var password: Observable<String> { return passwordTextField.rx.value.orEmpty.asObservable() }

    var submitDidPressed: Observable<Void> { return submitButton.rx.tap.asObservable() }

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInteface()
        prepareLayouts()
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}

// MARK: - Additional properties

extension LoginViewController {

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

}
