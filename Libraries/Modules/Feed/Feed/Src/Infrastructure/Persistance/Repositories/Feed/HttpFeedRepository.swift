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

    private let items = [
        HttpFeedItemEntity(itemId: "1", name: "", imageUrl: "https://picsum.photos/id/1055/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "2", name: "", imageUrl: "https://picsum.photos/id/147/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "3", name: "", imageUrl: "https://picsum.photos/id/539/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "4", name: "", imageUrl: "https://picsum.photos/id/835/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "5", name: "", imageUrl: "https://picsum.photos/id/830/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "6", name: "", imageUrl: "https://picsum.photos/id/841/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "7", name: "", imageUrl: "https://picsum.photos/id/508/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "8", name: "", imageUrl: "https://picsum.photos/id/397/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "9", name: "", imageUrl: "https://picsum.photos/id/452/200/200", updatedAt: ""),
        HttpFeedItemEntity(itemId: "10", name: "", imageUrl: "https://picsum.photos/id/973/200/200", updatedAt: "")
    ]

}

extension HttpFeedRepository: FeedRepository {

    // Mocked response

    func findAll() -> Observable<Result<[FeedItemEntity], DomainError>> {
        return .just(.success(items))
    }

    // Mocked response

    func find(itemId: String) -> Observable<Result<FeedItemEntity, DomainError>> {
        let item = items.filter ({ $0.itemId == itemId }).first ?? HttpFeedItemEntity(itemId: "1", name: "", imageUrl: "https://picsum.photos/id/1055/200/200", updatedAt: "")
        return .just(.success(item))
    }

}
