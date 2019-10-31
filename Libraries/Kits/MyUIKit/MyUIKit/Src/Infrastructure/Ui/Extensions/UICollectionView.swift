//
//  UICollectionView.swift
//  MyUIKit
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func dequeueReusableCell<Cell: UICollectionViewCell>(
        forIndexPath indexPath: IndexPath
    ) -> Cell where Cell: MUKReusableView {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell else { fatalError("Could not dequeue cell with identifier: \(Cell.identifier)") }

        return cell
    }

    func register<Cell: UICollectionViewCell>(cell: Cell.Type) where Cell: MUKReusableView {
        register(cell, forCellWithReuseIdentifier: Cell.identifier)
    }

}
