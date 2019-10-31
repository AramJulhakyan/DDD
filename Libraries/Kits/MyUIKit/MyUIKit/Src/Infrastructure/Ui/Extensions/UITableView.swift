//
//  UITableView.swift
//  MyUIKit
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import UIKit

public extension UITableView {

    func dequeueReusableCell<Cell: UITableViewCell>(
        forIndexPath indexPath: IndexPath
    ) -> Cell where Cell: MUKReusableView {
        guard let cell = dequeueReusableCell(
            withIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell else { fatalError("Could not dequeue cell with identifier: \(Cell.identifier)") }

        return cell
    }

    func register<Cell: UITableViewCell>(cell: Cell.Type) where Cell: MUKReusableView {
        register(cell, forCellReuseIdentifier: Cell.identifier)
    }

}
