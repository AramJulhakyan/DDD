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

    // MARK: - Properties

    lazy var items: [FeedItemDto] = { .init() }()

    private lazy var itemSubject = PublishSubject<String>()
    var itemSelected: Driver<String> {
        return itemSubject.asDriver(onErrorJustReturn: "")
    }

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

extension FeedViewController {

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
    ) -> CGSize { return .init(width: 80, height: 80) }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

}
