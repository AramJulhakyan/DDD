//
//  FeedViewModelProvider.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

struct FeedViewModelProvider {

    let logger: MFLog?

    let findAllItemsService: FindAllItemsService

}

extension FeedViewModelProvider {

    struct Input {
        var execute: Observable<Void>
    }

    struct Output {
        var result: Driver<Result<[FeedItemDto], FeedError>>
    }

}

extension FeedViewModelProvider: FeedViewModel {

    func transform(input: Input) -> Output {
        logger?.info(classType: type(of: self), line: #line, message: "Transforming ViewModel...")
        let result = input
            .execute
            .flatMapLatest { () -> Observable<Result<[FeedItemDto], FeedError>> in
                return self.findAllItemsService.execute()
            }
            .asDriver(onErrorJustReturn: .failure(.notFound))

        return Output(result: result)
    }

}
