//
//  FindItemViewModel.swift
//  Feed
//
//  Created by Miguel Angel on 31/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

protocol FindItemViewModel {

    var itemId: String { get set }

    func transform(input: FindItemViewModelProvider.Input) -> FindItemViewModelProvider.Output

}
