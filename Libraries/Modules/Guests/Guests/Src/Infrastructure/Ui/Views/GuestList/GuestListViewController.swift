//
//  GuestListViewController.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import MyUIKit
import SnapKit
import UIKit

class GuestListViewController: UIViewController {

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

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Properties

    lazy var items: [GuestDto] = { .init() }()

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

    func reloadData() {
        guestsTableView.reloadData()
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

}
