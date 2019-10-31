//
//  GuestListCoordinatorProvider.swift
//  Guests
//
//  Created by Toni Vecina on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxSwift

final class GuestListCoordinatorProvider: MUKRootViewCoordinator {

    // MARK: - Properties

    lazy var viewController: GuestListViewController = {
        let instance    = GuestListViewController()
        instance.logger = logger

        return instance
    }()

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var findMyGuestsSubject: PublishSubject<Void> = { .init() }()

    lazy var guestsList: [GuestDto] = { .init() }()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    var rootViewController: UIViewController? { return viewController }

    // MARK: - Dependencies

    var logger: MFLog?

    var findMyGuestsVM: FindMyGuestsViewModel?

    // MARK: - Lifecycle

    init(findMyGuestsVM: FindMyGuestsViewModel?, logger: MFLog?) {
        self.findMyGuestsVM = findMyGuestsVM
        self.logger         = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        bind(viewModel: findMyGuestsVM)
        findMyGuests()
    }
}

// MARK: - Additional properties

extension GuestListCoordinatorProvider {

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
        guestsList.removeAll()
        guestsList.append(contentsOf: guests)
        viewController.guestsTableView.reloadData()
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

        viewController.present(alertController, animated: true, completion: nil)
    }

    func findMyGuests() {
        findMyGuestsSubject.onNext(())
    }

}
