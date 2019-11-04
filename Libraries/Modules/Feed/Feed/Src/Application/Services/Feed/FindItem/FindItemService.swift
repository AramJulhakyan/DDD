//
//  FindItemService.swift
//  Feed
//
//  Created by Miguel Angel on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol FindItemService {

    func execute(itemId: String) -> Observable<Result<FeedItemDto, FeedError>>

}
