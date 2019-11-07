//
//  FindGuestByIdProvider.swift
//  Guests
//
//  Created by Aram Julhakyan on 06/11/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

class GuestDetailViewModelProvider {

    private var guestId: String
    let logger: MFLog?
    let findByIdService: FindByIdService

    init(guestId: String, service: FindByIdService, logger: MFLog? = nil) {
        self.guestId = guestId
        self.findByIdService = service
        self.logger = logger
    }

}

extension GuestDetailViewModelProvider {

    struct Input {
        let execute: Observable<Void>
    }

    struct Output {
        let result: Driver<Result<GuestDetailDto, GuestsError>>
    }

}

extension GuestDetailViewModelProvider: GuestDetailViewModel {

    func transform(input: Input) -> Output {
        logger?.info(classType: type(of: self), line: #line, message: "Transforming ViewModel...")

        let result = input
            .execute
            .flatMapLatest { () -> Observable<Result<GuestDetailDto, GuestsError>> in
				return self.findByIdService.execute(guestId: self.guestId)
            }
            .asDriver(onErrorJustReturn: .failure(.unknown))

        return Output(result: result)
    }

}
