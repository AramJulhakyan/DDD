//
//  AutoLoginServiceProvider.swift
//  Authentication
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

final class AutoLoginServiceProvider {

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Properties

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var outputSubject: PublishSubject<Result<Bool, Error>> = { .init() }()

    lazy var emailSubject: PublishSubject<String> = { .init() }()

    lazy var passwordSubject: PublishSubject<String> = { .init() }()

    lazy var submitSubject: PublishSubject<Void> = { .init() }()

    // Constructors

    init(logger: MFLog? = nil, loginVM: LoginViewModel) {
        self.logger = logger
        bind(viewModel: loginVM)
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Service released")
    }

}

// MARK: - Additional properties

extension AutoLoginServiceProvider {

    func bind(viewModel: LoginViewModel) {
        let input = LoginViewModelProvider.Input(
            email: emailSubject,
            password: passwordSubject,
            submit: submitSubject
        )

        let output = viewModel.transform(input: input)
        output.result.drive(onNext: { [unowned self] result in
            switch result {
            case .success:
                self.outputSubject.onNext(.success(true))

            case .failure:
                let error = NSError(domain: "Unauthorized", code: 400, userInfo: nil)
                self.outputSubject.onNext(.failure(error))
            }
        }).disposed(by: disposeBag)
    }

}

// MARK: - Service

extension AutoLoginServiceProvider: AutoLoginService {

    var output: Driver<Result<Bool, Error>> {
        return self.outputSubject.asDriver(onErrorJustReturn: .success(false))
    }

    func execute(email: String, password: String) {
        emailSubject.onNext(email)
        passwordSubject.onNext(password)
        submitSubject.onNext(())
    }

}
