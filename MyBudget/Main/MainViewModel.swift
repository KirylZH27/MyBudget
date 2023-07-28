//
//  MainViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import Foundation
import Combine
final class MainViewModel: HideAuthorizationNavigationResponder, TransactionWasAddedNavigationResponder {
    
    private (set) var isPresentAuthorization = PassthroughSubject<Bool,Never>()
    private (set) var showTransactionWasAddedAnimation = PassthroughSubject<Bool, Never>()
    
    func hideAuthorization() {
        isPresentAuthorization.send(false)
    }
    
    func showTransactionWasAddedNavigationResponder() {
        showTransactionWasAddedAnimation.send(true)
    }
    
}
