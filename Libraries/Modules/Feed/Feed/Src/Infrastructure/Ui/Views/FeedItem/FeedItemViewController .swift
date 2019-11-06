//
//  FeedItemViewController.swift
//  Feed
//
//  Created by Miguel Angel on 04/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class FeedItemViewController: UIViewController {

    // MARK: - Lifecycle

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    // MARK: - Properties

    private lazy var disposeBag: DisposeBag = { .init() }()

    private lazy var findItemSubject: PublishSubject<Void> = { .init() }()

    private lazy var dismissSubject = PublishSubject<Void>()

    // MARK: - Dependencies

    var logger: MFLog?

    var findItemVM: FindItemViewModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()

        bind(viewModel: findItemVM)
        findItemSubject.onNext(())
    }

    /// Needed to override since we have the swipe to go back and we have to notify the coordinator.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            dismissSubject.onNext(())
        }
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }
}

// MARK: - Additional properties

extension FeedItemViewController {

    var didDismiss: Driver<Void> { dismissSubject.asDriver(onErrorJustReturn: ()) }

    func prepareInterface() {
        view.backgroundColor = .white
        view.addSubview(itemImageView)
    }

    func prepareLayouts() {
        itemImageView.snp.makeConstraints { make in
            let inset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(inset)
            } else {
                make.edges.equalToSuperview().inset(inset)
            }
        }
    }

    func bind(viewModel: FindItemViewModel?) {
        let input = FindItemViewModelProvider.Input(execute: findItemSubject)
        let output = viewModel?.transform(input: input)

        output?.result.drive(onNext: { [weak self] result in
            self?.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<FeedItemDto, FeedError>) {
        switch result {
        case .success(let item):
            itemImageView.load(string: item.imageUrl)

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

        present(alertController, animated: true, completion: nil)
    }
}
