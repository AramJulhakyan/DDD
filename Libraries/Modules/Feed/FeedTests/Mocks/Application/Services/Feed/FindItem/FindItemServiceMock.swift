//
//  FindItemServiceMock.swift
//  FeedTests
//
//  Created by Toni Vecina on 07/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Feed

struct FindItemServiceMock: FindItemService {

    var observable: Observable<Result<FeedItemDto, FeedError>>?

    func execute(itemId: String) -> Observable<Result<FeedItemDto, FeedError>> {
        return observable ?? .just(.failure(.unknown))
    }

}
