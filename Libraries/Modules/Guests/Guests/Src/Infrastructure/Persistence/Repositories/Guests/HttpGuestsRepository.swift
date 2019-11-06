//
//  HttpGuestsRepository.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

struct HttpGuestsRepository {

    // HttpClient dependency here!

}

extension HttpGuestsRepository: GuestsRepository {

    // Mocked response

    func findAll() -> Observable<Result<[GuestEntity], DomainError>> {
        return .just(.success([
            HttpGuestEntity.mock(category: "Friend"),
            HttpGuestEntity.mock(category: "Cousin"),
            HttpGuestEntity.mock(category: "Father"),
            HttpGuestEntity.mock(category: "Friend"),
            HttpGuestEntity.mock(category: "Friend"),
            HttpGuestEntity.mock(category: "Mother"),
            HttpGuestEntity.mock(category: "Friend"),
            HttpGuestEntity.mock(category: "Grandpa"),
            HttpGuestEntity.mock(category: "Friend"),
            HttpGuestEntity.mock(category: "Friend")
        ]))
    }

}

// For a mocked response...

private extension HttpGuestEntity {

    static func mock(category: String) -> GuestEntity {
        return HttpGuestEntity(
            idGuest: "id\(Int.random(in: 1...10000))",
            name: "Guest \(Int.random(in: 1...100))",
            category: category,
            numberOfPhotos: Int.random(in: 1...1000),
            updatedAt: "2019-10-25 16:30:00",
            profileUrl: "SomeUrl"
        )
    }
}
