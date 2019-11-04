//
//  FindItemViewModelProvider.swift
//  Feed
//
//  Created by Miguel Angel on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

struct FindItemViewModelProvider {

    let logger: MFLog?

    let findItemService: FindItemService

}

extension FindItemViewModelProvider {

    struct Input {
        let itemId: String
        let execute: Observable<Void>
    }

    struct Output {
        let result: Driver<Result<FeedItemDto, FeedError>>
    }

}

extension FindItemViewModelProvider: FindItemViewModel {

    func transform(input: Input) -> Output {
        let result = input
            .execute
            .flatMapLatest { _ -> Observable<Result<FeedItemDto, FeedError>> in
                guard !input.itemId.isEmpty else { return .just(.failure(.notFound)) }

                return self.findItemService.execute(itemId: input.itemId)
            }
            .asDriver(onErrorJustReturn: .failure(.notFound))

        return Output.init(result: result)
    }

}
