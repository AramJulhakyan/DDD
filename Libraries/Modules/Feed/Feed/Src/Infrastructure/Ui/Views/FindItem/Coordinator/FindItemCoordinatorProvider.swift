//
//  FindItemCoordinatorProvider.swift
//  Feed
//
//  Created by Miguel Angel on 04/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import UIKit

final class FindItemCoordinatorProvider: FindItemCoordinator {

    // MARK: Properties

    lazy var viewController: FindItemViewController = {
        let viewController = FindItemViewController()
        viewController.logger = logger

        return viewController
    }()

    var rootViewController: UIViewController? { return viewController }

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var findItemSubject: PublishSubject<Void> = { .init() }()

    lazy var dismissSubject = PublishSubject<Void>()
    var didDismiss: Driver<Void> {
        dismissSubject.asDriver(onErrorJustReturn: ())
    }

    // MARK: - Dependencies

    var logger: MFLog?

    var findItemVM: FindItemViewModel?

    var itemId: String?

    // MARK: - Lifecycle

    init(findItemVM: FindItemViewModel?, logger: MFLog?) {
        self.findItemVM = findItemVM
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        bind()
        bind(viewModel: findItemVM)
        findItemSubject.onNext(())
    }
}

// MARK: - Additional properties

extension FindItemCoordinatorProvider {

    func bind() {
        viewController.didDismiss
            .drive(dismissSubject)
            .disposed(by: disposeBag)
    }

    func bind(viewModel: FindItemViewModel?) {
        let itemId = self.itemId ?? ""
        let input = FindItemViewModelProvider.Input(itemId: itemId, execute: findItemSubject)
        let output = viewModel?.transform(input: input)
        output?.result
            .drive(onNext: { [weak self] result in
                self?.bind(result: result)
            })
            .disposed(by: disposeBag)
    }

    func bind(result: Result<FeedItemDto, FeedError>) {
        switch result {
        case .success(let item):
            viewController.imageUrl = URL(string: item.imageUrl)
        case .failure(let error):
            presentAlertError(error: error)
        }
    }

    func presentAlertError(error: FeedError) {
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default
        ) { [weak self] _ in
            self?.findItemSubject.onNext(()
        )}

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive
        )

        let alertController = UIAlertController(
            title: "Attention!",
            message: "An error ocurred",
            preferredStyle: .alert
        )
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)

        viewController.present(alertController, animated: true, completion: nil)
    }

}
