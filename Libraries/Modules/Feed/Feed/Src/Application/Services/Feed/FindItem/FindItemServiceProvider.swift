//
//  FindItemServiceProvider.swift
//  Feed
//
//  Created by Miguel Angel on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxSwift

struct FindItemServiceProvider {

    let logger: MFLog?

    let repository: FeedRepository

}

extension FindItemServiceProvider: FindItemService {

    func execute(itemId: String) -> Observable<Result<FeedItemDto, FeedError>> {

        logger?.info(classType: type(of: self), line: #line, message: "Finding item with id: \(itemId)")

        return repository.find(itemId: itemId).flatMapLatest { result -> Observable<Result<FeedItemDto, FeedError>> in
            switch result {
            case .success(let value):
                let data = FeedItemDto(imageUrl: value.imageUrl)
                return .just(.success(data))
            case .failure(let error):
                switch error {
                case .notFound:
                    return .just(.failure(.notFound))
                default:
                    return .just(.failure(.unknown))
                }
            }
        }
    }

}
