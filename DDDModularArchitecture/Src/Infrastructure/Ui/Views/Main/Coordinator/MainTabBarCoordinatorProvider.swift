//
//  MainTabBarCoordinatorProvider.swift
//  DDDModularArchitecture
//
//  Created by Toni Vecina on 30/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Feed
import Guests
import MyFoundation
import MyUIKit
import RxCocoa
import RxSwift
import UIKit

final class MainTabBarCoordinatorProvider: MainTabBarCoordinator {

    // MARK: - Properties

    let disposeBag = DisposeBag()

    lazy var tabBarController: MainTabBarController = {
        let instance    = MainTabBarController()
        instance.logger = logger

        return instance
    }()

    lazy var childCoordinators: [MUKCoordinator] = { .init() }()

    lazy var settingsCoordinator: SettingsCoordinator = { Coordinators.settingsCoordinator }()

    lazy var dismissSubject: PublishSubject<Void> = { .init() }()

    var rootViewController: UIViewController? { return tabBarController }

    var dismiss: Driver<Void> { return dismissSubject.asDriver(onErrorJustReturn: ()) }

    // MARK: - Dependencies

    var logger: MFLog?

    // MARK: - Lifecycle

    init(logger: MFLog?) {
        self.logger = logger
    }

    deinit {
        logger?.info(classType: type(of: self), line: #line, message: "Coordinator released")
    }

    func start() {
        var viewControllers = [UIViewController]()

        if let value = feedVC { viewControllers.append(value) }

        if let value = guestListVC { viewControllers.append(value) }

        if let value = settingsVC { viewControllers.append(value) }

        tabBarController.viewControllers = viewControllers
    }

}

// MARK: - Additional properties

extension MainTabBarCoordinatorProvider {

    var feedVC: UIViewController? {
        let feedCoordinator = FeedCoordinators.feedCoordinator
        guard let rootViewController = feedCoordinator.rootViewController else { return nil }

        let navigationController = UINavigationController(rootViewController: rootViewController)

        navigationController.tabBarItem = .init(title: "Feed", image: nil, tag: 0)
        navigationController.navigationBar.topItem?.title = "Feed"

        feedCoordinator.start()
        addChildCoordinator(feedCoordinator)

        return navigationController
    }

    var guestListVC: UIViewController? {
        let guestListCoordinator = GuestsCoordinators.guestListCoordinator
        guard let rootViewController = guestListCoordinator.rootViewController else { return nil }

        rootViewController.tabBarItem = .init(title: "Guests", image: nil, tag: 1)

        guestListCoordinator.start()
        addChildCoordinator(guestListCoordinator)

        return rootViewController
    }

    var settingsVC: UIViewController? {
        let settingsCoordinator = Coordinators.settingsCoordinator
        settingsCoordinator
            .logout
            .drive(onNext: { [unowned self] in
                self.childCoordinators.removeAll()
                self.dismissSubject.onNext(())
            })
            .disposed(by: disposeBag)

        guard let rootViewController = settingsCoordinator.rootViewController else { return nil }

        rootViewController.tabBarItem = .init(title: "Logout", image: nil, tag: 2)

        settingsCoordinator.start()
        addChildCoordinator(settingsCoordinator)

        return rootViewController
    }

}
