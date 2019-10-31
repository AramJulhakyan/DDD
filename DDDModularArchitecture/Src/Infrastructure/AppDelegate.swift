//
//  AppDelegate.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyUIKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    lazy var appCoordinator: MUKCoordinator = { Infrastructure.appCoordinator }()

}

// MARK: - UIApplication delegate

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        appCoordinator.start()

        return true
    }

}
