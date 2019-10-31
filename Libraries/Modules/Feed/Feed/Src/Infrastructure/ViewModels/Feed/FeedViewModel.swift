//
//  FeedViewModel.swift
//  Feed
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxCocoa
import RxSwift

protocol FeedViewModel {

    func transform(input: FeedViewModelProvider.Input) -> FeedViewModelProvider.Output

}
