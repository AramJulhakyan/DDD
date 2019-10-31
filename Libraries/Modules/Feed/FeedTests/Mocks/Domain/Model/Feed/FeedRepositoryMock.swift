//
//  FeedRepositoryMock.swift
//  FeedTests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation
import RxSwift

@testable import Feed

struct FeedRepositoryMock {

    var observable: Observable<Result<[FeedItemEntity], DomainError>>?

}

extension FeedRepositoryMock: FeedRepository {

    func findAll() -> Observable<Result<[FeedItemEntity], DomainError>> {
        return observable ?? .just(.failure(.notFound(message: "Mock error")))
    }

}
