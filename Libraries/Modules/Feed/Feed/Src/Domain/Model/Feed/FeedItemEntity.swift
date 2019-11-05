//
//  FeedItemEntity.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol FeedItemEntity {

    var itemId: String { get }

    var name: String { get }

    var imageUrl: String { get }

    var updatedAt: String { get }

}
