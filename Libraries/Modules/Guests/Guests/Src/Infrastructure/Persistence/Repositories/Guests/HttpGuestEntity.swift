//
//  HttpGuestEntity.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

struct HttpGuestEntity: GuestEntity {

    var name: String

    var category: String

    var numberOfPhotos: Int

    var updatedAt: String?

    var profileUrl: String?

}
