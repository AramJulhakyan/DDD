//
//  LoginCoordinator.swift
//  Authentication
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyUIKit
import RxCocoa

public protocol LoginCoordinator: MUKRootViewCoordinator {

    var output: Driver<(email: String, password: String)> { get }

}
