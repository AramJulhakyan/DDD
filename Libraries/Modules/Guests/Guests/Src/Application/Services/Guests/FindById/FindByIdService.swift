//
//  FindByIdService.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol FindByIdService {

	func execute(guestId: String) -> Observable<Result<GuestDetailDto, GuestsError>>

}
