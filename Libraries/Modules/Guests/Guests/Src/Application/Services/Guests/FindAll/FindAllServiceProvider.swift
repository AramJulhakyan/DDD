//
//  FindAllServiceProvider.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxSwift

struct FindAllServiceProvider {

    let logger: MFLog?
    let repository: GuestsRepository

}

extension FindAllServiceProvider: FindAllService {

    func execute() -> Observable<Result<[GuestDto], GuestsError>> {
        logger?.info(classType: type(of: self), line: #line, message: "Finding all guests...")

        return repository
            .findAll()
            .flatMapLatest { result -> Observable<Result<[GuestDto], GuestsError>> in
                switch result {
                case .success(let value):
                    let data = value.map { entity -> GuestDto in
                        return GuestDto(
                            name: entity.name,
                            category: entity.category,
                            numberOfPhotos: entity.numberOfPhotos,
                            idGuest: entity.idGuest
                        )
                    }
                    return .just(.success(data))

                case .failure(let error):
                    switch error {
                    case .notFound: return .just(.failure(.notFound))
                    default:        return .just(.failure(.unknown))
                    }
                }
        }
    }
}
