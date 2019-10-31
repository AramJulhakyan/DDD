//
//  LoginService.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxSwift

protocol LoginService {

    func execute(email: String, password: String) -> Observable<Result<String, AuthError>>

}
