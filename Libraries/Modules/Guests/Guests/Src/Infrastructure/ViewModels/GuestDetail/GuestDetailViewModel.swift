//
//  FindGuestByIdViewModel.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import Foundation

protocol GuestDetailViewModel {
	func transform(input: GuestDetailViewModelProvider.Input) -> GuestDetailViewModelProvider.Output
}
