//
//  FeedViewController.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class FeedViewController: UIViewController {

    // MARK: - Interface

    lazy var itemCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical

        let instance = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        instance.register(cell: MUKImageCollectionViewCell.self)

        instance.backgroundColor                = .clear
        instance.alwaysBounceHorizontal         = false
        instance.alwaysBounceVertical           = true
        instance.showsHorizontalScrollIndicator = false
        instance.showsVerticalScrollIndicator   = false

        instance.dataSource                     = self
        instance.delegate                       = self

        return instance
    }()

    // MARK: - Dependencies

    var logger: MFLog?

    var viewModel: FeedViewModel?

    // MARK: - Properties

    private lazy var disposeBag: DisposeBag = { .init() }()

    private lazy var findItemsSubject: PublishSubject<Void> = { .init() }()

    private lazy var itemSubject: PublishSubject<String> = { .init() }()

    private lazy var items: [FeedItemDto] = { .init() }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()

        bind(viewModel: viewModel)
        getFeed()
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}

// MARK: - Additional properties

extension FeedViewController {

    var itemDidSelect: Driver<String> { itemSubject.asDriver(onErrorJustReturn: "") }

    func prepareInterface() {
        view.backgroundColor = .white
        view.addSubview(itemCollectionView)
    }

    func prepareLayouts() {
        itemCollectionView.snp.makeConstraints { make in
            let inset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaLayoutGuide).inset(inset)
            } else {
                make.edges.equalToSuperview().inset(inset)
            }
        }
    }

    func bind(viewModel: FeedViewModel?) {
        let input = FeedViewModelProvider.Input(execute: findItemsSubject)
        let output = viewModel?.transform(input: input)

        output?.result.drive(onNext: { [unowned self] result in
            self.bind(result: result)
        }).disposed(by: disposeBag)
    }

    func bind(result: Result<[FeedItemDto], FeedError>) {
        switch result {
        case .success(let value): bindAndReload(items: value)
        case .failure(let error): presentAlertError(error: error)
        }
    }

    func bindAndReload(items: [FeedItemDto]) {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        itemCollectionView.reloadData()
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

        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - UICollectionView data source

extension FeedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MUKImageCollectionViewCell
        cell.imageView.load(string: item.imageUrl)

        return cell
    }

}

// MARK: - UICollectionView delegate

extension FeedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        itemSubject.onNext(item.itemId)
    }

}

// MARK: - UICollectionView FlowLayout delegate

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize { .collectionViewItemSize }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets { .collectionViewInset }

}

private extension CGSize {

    static var collectionViewItemSize: CGSize { .init(width: 80, height: 80) }

}

private extension UIEdgeInsets {

    static var collectionViewInset: UIEdgeInsets { .init(top: 16, left: .zero, bottom: 16, right: .zero) }

}
