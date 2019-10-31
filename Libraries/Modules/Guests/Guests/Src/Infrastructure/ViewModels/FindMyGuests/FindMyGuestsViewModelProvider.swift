//
//  FindMyGuestsViewModelProvider.swift
//  Guests
//
//  Created by Toni Vecina on 26/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import MyFoundation
import RxCocoa
import RxSwift

struct FindMyGuestsViewModelProvider {

    let logger: MFLog?
    let findAllService: FindAllService

}

extension FindMyGuestsViewModelProvider {

    struct Input {
        let execute: Observable<Void>
    }

    struct Output {
        let result: Driver<Result<[GuestDto], GuestsError>>
    }

}

extension FindMyGuestsViewModelProvider: FindMyGuestsViewModel {

    func transform(input: Input) -> Output {
        logger?.info(classType: type(of: self), line: #line, message: "Transforming ViewModel...")

        let result = input
            .execute
            .flatMapLatest { () -> Observable<Result<[GuestDto], GuestsError>> in
                return self.findAllService.execute()
            }
            .asDriver(onErrorJustReturn: .failure(.unknown))

        return Output(result: result)
    }

}
