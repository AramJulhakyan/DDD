//
//  AutoLoginService.swift
//  Authentication
//
//  Created by Toni Vecina on 27/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

import RxCocoa
import RxSwift

public protocol AutoLoginService {

    var output: Driver<Result<Bool, Error>> { get }

    func execute(email: String, password: String)

}
