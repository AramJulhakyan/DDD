//
//  FindByIdServiceProvider.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxSwift

struct FindByIdServiceProvider {

    let logger: MFLog?
    let repository: GuestsRepository

}

extension FindByIdServiceProvider: FindByIdService {
	func execute(guestId: String) -> Observable<Result<GuestDetailDto, GuestsError>> {
		logger?.info(classType: type(of: self), line: #line, message: "Finding guest with id \(guestId)...")

        return repository
            .findById(guestId: guestId)
            .flatMapLatest { result -> Observable<Result<GuestDetailDto, GuestsError>> in
                switch result {
                case .success(let value):
					let guestDto =  GuestDetailDto(
                            name: value.name,
                            category: value.category,
                            guestURLString: value.profileUrl ?? ""
                        )

                    return .just(.success(guestDto))

                case .failure(let error):
                    switch error {
                    case .notFound: return .just(.failure(.notFound))
                    default:        return .just(.failure(.unknown))
                    }
                }
        }
	}
}
