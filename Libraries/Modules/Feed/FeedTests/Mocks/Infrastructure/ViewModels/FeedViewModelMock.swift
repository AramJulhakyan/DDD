//
//  FeedViewModelMock.swift
//  FeedTests
//
//  Created by Toni Vecina on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift
@testable import Feed

struct FeedViewModelMock: FeedViewModel {

    var observable: Observable<Result<[FeedItemDto], FeedError>>?

    func transform(input: FeedViewModelProvider.Input) -> FeedViewModelProvider.Output {
        let result = observable ?? .just(.failure(.notFound))
        return FeedViewModelProvider.Output(result: result.asDriver(onErrorJustReturn: .failure(.notFound)))
    }

}
