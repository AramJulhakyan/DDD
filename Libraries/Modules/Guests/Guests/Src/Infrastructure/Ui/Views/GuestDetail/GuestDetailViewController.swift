//
//  GuestDetailViewController.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class GuestDetailViewController: UIViewController {

	private let disposeBag = DisposeBag()

	// MARK: - Output
	var didTapClose: Driver<Void> {
		return closeSubject.asDriver(onErrorJustReturn: ())
    }
	private let closeSubject = PublishSubject<Void>()

    // MARK: - Interface
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.textAlignment = .center
		return label
	}()

	private lazy var categoryLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 26)
		label.textAlignment = .center
		return label
	}()

	private lazy var profileURLLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textAlignment = .center
		return label
	}()

	private lazy var closeButton: UIButton = {
		let button = UIButton(type: .custom)
		button.backgroundColor = .gray
		button.setTitle("Close", for: .normal)
		return button
	}()

	// MARK: - Dependencies
	var guestDetailViewModel: GuestDetailViewModel?

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()
		bind()
    }
}

extension GuestDetailViewController {

	func prepareInterface() {
		view.backgroundColor = .white
		view.addSubview(closeButton)
		view.addSubview(nameLabel)
		view.addSubview(categoryLabel)
		view.addSubview(profileURLLabel)
	}

	func prepareLayouts() {

		closeButton.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview().inset(10)
			make.height.equalTo(65)
		}

		nameLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalToSuperview().offset(100)
		}

		categoryLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(nameLabel.snp.bottom).offset(50)
		}

		profileURLLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(categoryLabel.snp.bottom).offset(50)
		}
	}

	func bind() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map {_ in}
        let input = GuestDetailViewModelProvider.Input(execute: viewWillAppear)
        let output = guestDetailViewModel?.transform(input: input)
        output?.result.drive(onNext: { [unowned self] result in
            switch result {
            case .success(let detailDto):
                self.nameLabel.text = detailDto.name
                self.categoryLabel.text = detailDto.category
                self.profileURLLabel.text = detailDto.guestURLString
            case .failure(let guestError):
                print ("Error loading the user detail: \(guestError)")
            }
        }).disposed(by: disposeBag)

		closeButton.rx.tap.asDriver()
			.drive(closeSubject)
			.disposed(by: disposeBag)
	}
}
