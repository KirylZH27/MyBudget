//
//  AuthorizationManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import Foundation

enum AuthorizationType {
    case google
}

protocol AuthorizationManager {
    typealias AuthorizationResult = Result<String, Error>
    func requestAuthorization(in type: AuthorizationType, completion: @escaping (AuthorizationResult) -> Void)
}


