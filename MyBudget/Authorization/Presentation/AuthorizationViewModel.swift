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
    private let userStore: UserStore
    private (set) var isPresentUserAdditional = PassthroughSubject<Bool,Never>()
    
    init(authorizationManager: AuthorizationManager, userStore: UserStore) {
        self.authorizationManager = authorizationManager
        self.userStore = userStore
    }
    
    func requestGoogleAuthorization() {
        authorizationManager.requestAuthorization(in: .google) { [weak self] result in
            switch result {
                case .success(let userId):
                    
                    self?.userStore.checkIfUserExist(by: userId) { [weak self] isExist in
                        if isExist {
                            self?.isPresentUserAdditional.send(false)
                        } else {
                            self?.isPresentUserAdditional.send(true)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            print(result)
        }
    }
}
