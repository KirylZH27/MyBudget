//
//  GoogleAuthorizationClient.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import Foundation

struct GoogleAuthorizationResult {
    let idToken: String
    let accessToken: String
}

protocol GoogleAuthorizationClient {
    typealias Result = Swift.Result<GoogleAuthorizationResult, Error>
    func requestAuthorization(completion: @escaping (Result) -> Void) 
}
