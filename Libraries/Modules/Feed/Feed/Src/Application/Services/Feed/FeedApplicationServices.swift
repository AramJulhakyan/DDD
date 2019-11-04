//
//  FeedApplicationServices.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation

protocol FeedApplicationServices {/* empty */}

private extension FeedApplicationServices {

    func get() -> MFLog { return Assembler() }

    func get() -> FeedRepository { return Assembler().feed }

}

extension FeedApplicationServices {

    var findAllItems: FindAllItemsService {
        return FindAllItemsServiceProvider(logger: get(), repository: get())
    }

    var findItem: FindItemService {
        return FindItemServiceProvider(logger: get(), repository: get())
    }

}

private struct Assembler: MFLog, PersistanceRepositories {/* empty */}
