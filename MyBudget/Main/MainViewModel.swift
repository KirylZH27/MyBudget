//
//  MainViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import Foundation
import Combine
final class MainViewModel: HideAuthorizationNavigationResponder {
    
    private (set) var isPresentAuthorization = PassthroughSubject<Bool,Never>()
    
    func hideAuthorization() {
        isPresentAuthorization.send(false)
    }
    
    
}
