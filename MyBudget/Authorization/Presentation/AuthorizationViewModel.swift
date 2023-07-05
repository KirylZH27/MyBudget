//
//  AuthorizationViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import Foundation
import Combine

final class AuthorizationViewModel {
    private let authorizationManager: AuthorizationManager
    private (set) var isPresentUserAdditional = PassthroughSubject<Bool,Never>()
    
    init(authorizationManager: AuthorizationManager) {
        self.authorizationManager = authorizationManager
    }
    func requestGoogleAuthorization() {
        authorizationManager.requestAuthorization(in: .google) { [weak self] result in
            switch result {
                case .success(let userId):
                    self?.isPresentUserAdditional.send(true)
                    
                case .failure(let error):
                    print(error.localizedDescription)
            }
            print(result)
        }
    }
}
