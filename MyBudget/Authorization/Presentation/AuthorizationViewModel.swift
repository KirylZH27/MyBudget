//
//  AuthorizationViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import Foundation

final class AuthorizationViewModel {
    private let authorizationManager: AuthorizationManager
    
    init(authorizationManager: AuthorizationManager) {
        self.authorizationManager = authorizationManager
    }
    func requestGoogleAuthorization() {
        authorizationManager.requestAuthorization(in: .google) { [weak self] result in
            <#code#>
        }
    }
}
