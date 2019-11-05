//
//  FindItemCoordinator.swift
//  Feed
//
//  Created by Miguel Angel on 05/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyUIKit
import RxCocoa

protocol FindItemCoordinator: MUKRootViewCoordinator {

    var itemId: String? { get set }
    var didDismiss: Driver<Void> { get }

}
