//
//  MainTabBarController.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Feed
import Guests
import MyFoundation
import RxCocoa
import RxSwift
import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Lifecycle

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "ViewController released")
    }

}
