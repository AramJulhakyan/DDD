//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Toni Vecina on 25/10/2019.
//  Copyright © 2019 Toni Vecina. All rights reserved.
//

protocol LoginViewModel {

    func transform(input: LoginViewModelProvider.Input) -> LoginViewModelProvider.Output

}
