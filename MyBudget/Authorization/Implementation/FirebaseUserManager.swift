//
//  FirebaseUserManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
import FirebaseAuth

final class FirebaseUserManager: UserCreator {
    private let userStore: UserStore
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    func createUserIfNeeded(with user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        userStore.checkIfUserExist(by: user.id) { [weak self] isExist in
            if isExist {
                completion(.success(()))
            } else {
                self?.userStore.create(user: user, completion: completion)
            }
        }
    }
}
