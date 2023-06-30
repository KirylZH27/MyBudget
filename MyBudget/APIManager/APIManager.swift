//
//  APIManager.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
import Firebase
import FirebaseDatabase

class APIManager {
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func createUser(userID: String, email: String){
        let dataBase = configureFB()
        dataBase.collection("users").document(userID).setData(["email" : email])
    }
    
    func getUserInformation(userId: String,completion: @escaping (Result<UserModel, Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("users").document(userId).getDocument { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                guard let data = result.data() else { return }
                guard let email = data["email"] as? String else { return }
                guard let name = data["name"] as? String else { return }
                guard let imageURLString = data["imageURL"] as? String else {return}
                
                // ???
                let userModel = UserModel(email: email, name: name, imageURLString: imageURLString)
                completion(.success(userModel))
            }
        }
    }
    
    func setNewProfileInfo(userId: String, newProfile: UserModel, completion: @escaping (Result<Void, Error>) -> Void){
        let dataBase = configureFB()
        var data: [String: String] = ["email": newProfile.email]
        if newProfile.name != nil {
            data["name"] = newProfile.name!
        }
        if newProfile.imageURLString != nil {
            data["imageURLString"] = newProfile.imageURLString!
        }
        dataBase.collection("users").document(userId).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                completion(.success(Void()))
            }
        }
    }
}

