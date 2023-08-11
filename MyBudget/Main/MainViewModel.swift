//
//  MainViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import Foundation
import Combine
import FirebaseAuth
final class MainViewModel: HideAuthorizationNavigationResponder, TransactionWasAddedNavigationResponder, SignOutNavigationResponder, ShowUserAditionalInfoNavigationResponder, HideUserAdditionalInfoNavigationResponder {
    
    private let userStore: UserStore
    
    private (set) var isPresentAuthorization = PassthroughSubject<Bool,Never>()
    private (set) var showTransactionWasAddedAnimation = PassthroughSubject<Bool, Never>()
    private (set) var isPresentUserAdditionalInfo = PassthroughSubject<Bool,Never>()
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    func hideAuthorization() {
        isPresentAuthorization.send(false)
    }
    
    func showTransactionWasAddedNavigationResponder() {
        showTransactionWasAddedAnimation.send(true)
    }
    
    func checkAuthorization(){
        let user = Auth.auth().currentUser
        if let user = user{
            userStore.checkIfUserExist(by: user.uid) { userExist in
                if userExist {
                    self.isPresentAuthorization.send(false)
                } else {
                    self.isPresentUserAdditionalInfo.send(true)
                }
            }
        } else {
            isPresentAuthorization.send(true)
        }
    }
    
    func signOut() {
        isPresentAuthorization.send(true)
    }
    
    func hideUserAdditionalInfo() {
        isPresentUserAdditionalInfo.send(false)
    }
    
    func showUserAdditionalInfo() {
        isPresentUserAdditionalInfo.send(true)
    }
    
}
