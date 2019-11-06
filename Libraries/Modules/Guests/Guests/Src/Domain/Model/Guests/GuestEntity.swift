//
//  GuestEntity.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol GuestEntity {

    var idGuest: String { get }

    var name: String { get }

    var category: String { get }

    var numberOfPhotos: Int { get }

    var updatedAt: String? { get }

    var profileUrl: String? { get }

}
