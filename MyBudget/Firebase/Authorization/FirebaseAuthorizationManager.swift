//
//  FirebaseAuthorizationManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import FirebaseAuth
import FirebaseFirestore

protocol FirebaseAuth {
    func requestUserId(with credential: AuthCredential, completion: @escaping(String?, Error?) -> Void)
}

extension Auth: FirebaseAuth {
    func requestUserId(with credential: AuthCredential, completion: @escaping (String?, Error?) -> Void) {
        signIn(with: credential) { authResult, error in
            completion(authResult?.user.uid, error)
        }
    }
}

final class FirebaseAuthorizationManager: AuthorizationManager {
    
    private let googleAuthorizationClient: GoogleAuthorizationClient
    private var completion: ((AuthorizationResult) -> Void)?
    private let auth: FirebaseAuth
    
    enum Error: Swift.Error {
        case missingUserId
    }
    
    init(googleAuthorizationClient: GoogleAuthorizationClient, auth: FirebaseAuth) {
        self.googleAuthorizationClient = googleAuthorizationClient
        self.auth = auth
    }
    
    func requestAuthorization(in type: AuthorizationType, completion: @escaping (AuthorizationResult) -> Void) {
        switch type {
            case .google:
                googleAuthorizationClient.requestAuthorization { [weak self] result in
                    switch result {
                        case .success(let authResult):
                            self?.signInFirebase(with: authResult)
                        case .failure(let error):
                            completion(.failure(error))
                    }
                }
        }
        self.completion = completion
    }
    
    private func signInFirebase(with authorizationResult: GoogleAuthorizationResult) {
        let credential = GoogleAuthProvider.credential(withIDToken: authorizationResult.idToken, accessToken: authorizationResult.accessToken)
        signInFirebase(with: credential)
    }
    
    private func signInFirebase(with credentials: AuthCredential) {
        auth.requestUserId(with: credentials) { [weak self] (userId, error) in
            if let error = error {
                self?.completion?(.failure(error))
                return
            }
            guard let userId = userId else {
                self?.completion?(.failure(Error.missingUserId))
                return }
            self?.completion?(.success(userId))
        }
    }
}
