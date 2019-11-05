//
//  FindAllItemsServiceProvider.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxSwift

struct FindAllItemsServiceProvider {

    let logger: MFLog?
    let repository: FeedRepository

    init(logger: MFLog? = nil, repository: FeedRepository) {
        self.logger = logger
        self.repository = repository
    }

}

extension FindAllItemsServiceProvider: FindAllItemsService {

    func execute() -> Observable<Result<[FeedItemDto], FeedError>> {
        logger?.info(classType: type(of: self), line: #line, message: "Getting all feed items...")
        return repository
            .findAll()
            .flatMapLatest { result -> Observable<Result<[FeedItemDto], FeedError>> in
                switch result {
                case .failure(let error):
                    switch error {
                    case .notFound: return .just(.failure(.notFound))
                    default:        return .just(.failure(.unknown))
                    }

                case .success(let items):
                    let data = items.map { item -> FeedItemDto in
                        FeedItemDto(itemId: item.itemId, imageUrl: item.imageUrl)
                    }
                    return .just(.success(data))
                }
        }
    }

}
