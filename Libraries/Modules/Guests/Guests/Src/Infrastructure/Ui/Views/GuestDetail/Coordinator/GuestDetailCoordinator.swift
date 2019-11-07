//
//  GuestDetailCoordinator.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import MyUIKit
import RxCocoa

public protocol GuestDetailCoordinator: MUKRootViewCoordinator {
	var detailDidClose: Driver<Void> { get }
}
