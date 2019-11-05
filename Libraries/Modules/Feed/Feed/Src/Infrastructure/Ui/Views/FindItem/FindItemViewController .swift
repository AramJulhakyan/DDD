//
//  FindItemViewController.swift
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

final class FindItemViewController: UIViewController {

    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Properties

    lazy var disposeBag: DisposeBag = { .init() }()

    lazy var imageURLSubject: ReplaySubject<URL> = { .create(bufferSize: 1) }()

    private lazy var dismissSubject = PublishSubject<Void>()
    var didDismiss: Driver<Void> {
        return dismissSubject.asDriver(onErrorJustReturn: ())
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareInterface()
        prepareLayouts()
        bind()
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }
}

// MARK: - Additional properties

extension FindItemViewController {

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

    func bind() {
        imageURLSubject
            .subscribe(onNext: { [weak self] url in
                self?.itemImageView.load(url: url)
            })
            .disposed(by: disposeBag)
    }

}

extension FindItemViewController {

    /// Needed to override since we have the swipe to go back and we have to notify the coordinator.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            dismissSubject.onNext(())
        }
    }

}
