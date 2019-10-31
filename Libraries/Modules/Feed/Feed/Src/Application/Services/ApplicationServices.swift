//
//  ApplicationServices.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

protocol ApplicationServices {/* empty */}

extension ApplicationServices {

    var feed: FeedApplicationServices { return Assembler() }

}

private struct Assembler: FeedApplicationServices {/* empty */}
