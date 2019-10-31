//
//  MUKCoordinator.swift
//  MyUIKit
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import UIKit

public protocol MUKCoordinator: class {

    var childCoordinators: [MUKCoordinator] { get set }

    func start()

}

public extension MUKCoordinator {

    func addChildCoordinator(_ coordinator: MUKCoordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: MUKCoordinator) {
        let index = childCoordinators.firstIndex { contentCoordinator -> Bool in
            return contentCoordinator === coordinator
        }

        guard let value = index else { return }
        childCoordinators.remove(at: value)
    }

}
