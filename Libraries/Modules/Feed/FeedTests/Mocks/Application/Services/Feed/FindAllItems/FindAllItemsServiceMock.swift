//
//  FindAllItemsServiceMock.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Feed

struct FindAllItemsServiceMock {

    var observable: Observable<Result<[FeedItemDto], FeedError>>?

}

extension FindAllItemsServiceMock: FindAllItemsService {

    func execute() -> Observable<Result<[FeedItemDto], FeedError>> {
        return observable ?? .just(.failure(.unknown))
    }

}
