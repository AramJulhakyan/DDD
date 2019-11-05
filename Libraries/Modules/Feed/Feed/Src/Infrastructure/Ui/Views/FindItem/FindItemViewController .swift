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

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Properties

    var imageUrl: URL? {
        didSet {
            guard let value = imageUrl else { return }
            itemImageView.load(url: value)
        }
    }

    private lazy var dismissSubject = PublishSubject<Void>()
    var didDismiss: Driver<Void> {
        return dismissSubject.asDriver(onErrorJustReturn: ())
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
