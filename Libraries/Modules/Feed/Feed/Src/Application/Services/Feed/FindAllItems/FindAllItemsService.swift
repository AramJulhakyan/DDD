//
//  FindAllItemsService.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol FindAllItemsService {

    func execute() -> Observable<Result<[FeedItemDto], FeedError>>

}
