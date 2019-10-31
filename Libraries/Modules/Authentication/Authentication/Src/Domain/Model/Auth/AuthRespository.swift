//
//  AuthRespository.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol AuthRepository {

    func login(email: String, password: String) -> Observable<Result<UserTokenEntity, DomainError>>

}
