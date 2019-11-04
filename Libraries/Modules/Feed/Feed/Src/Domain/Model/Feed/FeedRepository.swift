//
//  FeedRepository.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol FeedRepository {

    func findAll() -> Observable<Result<[FeedItemEntity], DomainError>>

    func find(itemId: String) -> Observable<Result<FeedItemEntity, DomainError>>

}
