//
//  GuestsRepository.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol GuestsRepository {

    func findAll() -> Observable<Result<[GuestEntity], DomainError>>

}
