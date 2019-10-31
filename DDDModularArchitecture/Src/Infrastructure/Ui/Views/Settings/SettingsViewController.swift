//
//  SettingsViewController.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

final class SettingsViewController: UIViewController {

    // MARK: - Interface

    private lazy var logoutButton: UIButton = {
        let instance = UIButton()
        instance.backgroundColor = .white
        instance.setTitleColor(.darkText, for: .normal)
        instance.setTitle("Close session", for: .normal)

        return instance
    }()

    var logoutDidPressed: Driver<Void> { return logoutButton.rx.tap.asDriver() }

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}

// MARK: - Additional properties

extension SettingsViewController {

    func prepareInterface() {
        view.backgroundColor = .white
        view.addSubview(logoutButton)
    }

    func prepareLayouts() {
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.center.equalToSuperview()
        }
    }

}
