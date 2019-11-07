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

    var itemId: String

    let logger: MFLog?

    let findItemService: FindItemService

}

extension FindItemViewModelProvider {

    struct Input {
        let execute: Observable<Void>
    }

    struct Output {
        let result: Driver<Result<FeedItemDto, FeedError>>
    }

}

extension FindItemViewModelProvider: FindItemViewModel {

    func transform(input: Input) -> Output {
        logger?.info(classType: type(of: self), line: #line, message: "Transforming ViewModel...")
        let result = input
            .execute
            .flatMapLatest { () -> Observable<Result<FeedItemDto, FeedError>> in
                guard !self.itemId.isEmpty else { return .just(.failure(.notFound)) }

                return self.findItemService.execute(itemId: self.itemId)
            }
            .asDriver(onErrorJustReturn: .failure(.notFound))

        return Output.init(result: result)
    }

}
