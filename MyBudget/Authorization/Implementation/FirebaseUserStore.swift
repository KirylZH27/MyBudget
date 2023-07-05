//
//  FirebaseUserStore.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirebaseUserStore: UserStore {
    
    private let userCollectionRef = Firestore.firestore().collection("users")
    
    func checkIfUserExist(by userID: String, completion: @escaping (Bool)->Void) {
        userCollectionRef.document(userID).getDocument { (document, error) in
            if let _ = error {
                return completion(false)
            }
            if let document = document, document.exists {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func create(user: UserModel, completion: @escaping (Result<Void, Error>)->Void) {
        let data: [String: Any] = ["userID": user.id,
                                   "email": user.email,
                                   "name": user.name,
                                   "imageURLString": user.imageURLString ?? ""]
        userCollectionRef.document(user.id).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func delete(user: UserModel , completion: @escaping (Result<Void, Error>)->Void) {
        let userForDelete = Auth.auth().currentUser
        userCollectionRef.document(user.id).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                userForDelete?.delete(completion: { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(()))
                })
            }
        }
    }
}
