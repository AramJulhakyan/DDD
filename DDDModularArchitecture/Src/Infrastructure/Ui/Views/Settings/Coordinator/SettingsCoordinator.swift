//
//  SettingsCoordinator.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyUIKit
import RxCocoa

protocol SettingsCoordinator: MUKRootViewCoordinator {

    var logout: Driver<Void> { get }

}
