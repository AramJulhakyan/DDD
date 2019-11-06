//
//  GuestListViewController.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxSwift
import SnapKit
import UIKit
import RxCocoa

class GuestListViewController: UIViewController {
	
	// MARK: - Output
	var didSelectGuest: Driver<String?> {
		return itemSelectedSubject.asDriver(onErrorJustReturn: nil)
    }

    // MARK: - Interface

    private lazy var guestsTableView: UITableView = {
        let instance = UITableView()
        instance.register(cell: MUKGuestTableViewCell.self)

        instance.estimatedRowHeight = 80.0
        instance.tableFooterView    = .init(frame: .zero)
        instance.dataSource         = self
        instance.delegate           = self

        return instance
    }()

    // MARK: - Properties

    private lazy var items: [GuestDto] = { .init() }()

    private lazy var disposeBag: DisposeBag = { .init() }()

    private lazy var findMyGuestsSubject: PublishSubject<Void> = { .init() }()

	private let itemSelectedSubject =  PublishSubject<String?>()

    // MARK: - Dependencies

    var logger: MFLog?

    var findMyGuestsVM: FindMyGuestsViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()

        bind(viewModel: findMyGuestsVM)
        findMyGuests()
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}

// MARK: - Additional properties

extension GuestListViewController {

    func prepareInterface() {
        view.backgroundColor = .white
        view.addSubview(guestsTableView)
    }

    func prepareLayouts() {
        guestsTableView.snp.makeConstraints { make in
            let inset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(inset)
            } else {
                make.edges.equalToSuperview().inset(inset)
            }
        }
    }

    func bind(viewModel: FindMyGuestsViewModel?) {
        let input = FindMyGuestsViewModelProvider.Input(execute: findMyGuestsSubject)
        let output = viewModel?.transform(input: input)
        output?.result.drive(onNext: { [unowned self] result in
            self.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<[GuestDto], GuestsError>) {
        switch result {
        case .success(let value): bindAndReload(guests: value)
        case .failure(let error): presentAlertError(error: error)
        }
    }

    func bindAndReload(guests: [GuestDto]) {
        items.removeAll()
        items.append(contentsOf: guests)
        reloadData()
    }

    func findMyGuests() {
        findMyGuestsSubject.onNext(())
    }

    func reloadData() {
        guestsTableView.reloadData()
    }

    func presentAlertError(error: GuestsError) {
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default
        ) { [unowned self] _ in self.findMyGuests() }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        let message: String
        switch error {
        case .notFound:
            message = "Guest list not found"
        default:
            message = "An error occurred"
        }

        let alertController = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)

        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - UITableView data source

extension GuestListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]

        let cell                = tableView.dequeueReusableCell(forIndexPath: indexPath) as MUKGuestTableViewCell
        cell.titleLabel.text    = item.name
        cell.subtitleLabel.text = "\(item.category) with \(item.numberOfPhotos) photos"

        return cell
    }

}

// MARK: - UITableView delegate

extension GuestListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		itemSelectedSubject.onNext(items[indexPath.row].idGuest)
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
