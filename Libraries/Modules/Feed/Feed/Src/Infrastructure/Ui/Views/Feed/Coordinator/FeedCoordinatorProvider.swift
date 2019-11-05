//
//  FeedCoordinatorProvider.swift
//  Feed
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import UIKit

final class FeedCoordinatorProvider: MUKRootViewCoordinator {

    // MARK: - Properties

    lazy var viewController: FeedViewController = {
        let instance    = FeedViewController()
        instance.logger = logger

        return instance
    }()

    var rootViewController: UIViewController? { return viewController }

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var findItemsSubject: PublishSubject<Void> = { .init() }()

    // MARK: - Dependencies

    var logger: MFLog?

    var feedVM: FeedViewModel?

    // MARK: - Lifecycle

    init(feedVM: FeedViewModel?, logger: MFLog?) {
        self.feedVM = feedVM
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        bind(viewModel: feedVM)
        getFeed()
    }

}

// MARK: - Additional properties

extension FeedCoordinatorProvider {

    func bind(viewModel: FeedViewModel?) {
        let input = FeedViewModelProvider.Input(execute: findItemsSubject)
        let output = viewModel?.transform(input: input)
        output?.result
            .drive(onNext: { [unowned self] result in
                self.bind(result: result)
            })
            .disposed(by: disposeBag)

        viewController.itemSelected
            .drive(onNext: { [weak self] itemId in
                self?.presentDetailView(for: itemId)
            })
            .disposed(by: disposeBag)
    }

    func bind(result: Result<[FeedItemDto], FeedError>) {
        switch result {
        case .success(let value): bindAndReload(items: value)
        case .failure(let error): presentAlertError(error: error)
        }
    }

    func bindAndReload(items: [FeedItemDto]) {
        viewController.items.removeAll()
        viewController.items.append(contentsOf: items)
        viewController.itemCollectionView.reloadData()
    }

    func getFeed() {
        findItemsSubject.onNext(())
    }

    func presentAlertError(error: FeedError) {
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default
        ) { [unowned self] _ in self.getFeed() }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

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

extension FeedCoordinatorProvider {

    private func presentDetailView(for itemId: String) {
        let findItemCoordinator = FeedCoordinators.findItemCoordinator
        guard let rootViewController = findItemCoordinator.rootViewController else { return }
        findItemCoordinator.itemId = itemId
        findItemCoordinator.start()
        addChildCoordinator(findItemCoordinator)

        findItemCoordinator.didDismiss
            .drive(onNext: { [weak self, unowned findItemCoordinator] in
                self?.removeChildCoordinator(findItemCoordinator)
            })
            .disposed(by: disposeBag)

        viewController.navigationController?.pushViewController(rootViewController, animated: true)
    }

}
