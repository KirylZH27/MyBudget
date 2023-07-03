//
//  MyBudgetGoogleAuthorizationClient.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import GoogleSignIn

final class MyBudgetGoogleAuthorizationClient: GoogleAuthorizationClient {
    
    enum Error: Swift.Error {
        case invalidGoogleAuthResult
    }
    
    private let clientId: String
    private let presentationController: UIViewController
    
    init(clientId: String, presentationController: UIViewController) {
        self.clientId = clientId
        self.presentationController = presentationController
    }
    
    func requestAuthorization(completion: @escaping (GoogleAuthorizationClient.Result) -> Void) {
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentationController) { result, error in
            if let error = error{
                return completion(.failure(error))
            }
            guard let user = result?.user,
                    let idToken = user.idToken?.tokenString
            else {
                return completion(.failure(Error.invalidGoogleAuthResult))
                
            }
            completion(.success(GoogleAuthorizationResult(idToken: idToken, accessToken: user.accessToken.tokenString)))
        }
    }
    
    
}
