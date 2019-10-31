//
//  HttpFeedRepository.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

struct HttpFeedRepository {

    // Place for 'HttpClient' dependency

}

extension HttpFeedRepository: FeedRepository {

    // Mocked response

    func findAll() -> Observable<Result<[FeedItemEntity], DomainError>> {
        return .just(.success([
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/1055/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/147/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/539/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/835/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/830/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/841/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/508/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/397/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/452/200/200", updatedAt: ""),
            HttpFeedItemEntity(name: "", imageUrl: "https://picsum.photos/id/973/200/200", updatedAt: "")
        ]))
    }

}
