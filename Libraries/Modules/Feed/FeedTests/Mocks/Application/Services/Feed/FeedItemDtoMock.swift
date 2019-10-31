//
//  FeedItemDtoMock.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

@testable import Feed

extension FeedItemDto {

    static var mock: FeedItemDto {
        return self.init(imageUrl: "test")
    }

}
