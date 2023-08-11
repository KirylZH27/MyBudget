//
//  FirebaseUserStore.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

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
        let data: [String: Any] = ["id": user.id,
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
    
    func save(user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let data: [String: Any] = ["id": user.id,
                                   "email": user.email,
                                   "name": user.name,
                                   "imageURLString": user.imageURLString ?? ""]
        
        userCollectionRef.document(user.id).setData(data, merge: true) { error in
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
    
    func getUser(uid: String,
                 completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        userCollectionRef.document(uid).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let userModel = UserModel(document: document?.data()) else { return }
                
                completion(.success(userModel))
            }
        }
    }
    
    /// Загрузить изображение в Firebase DataStorage и сохранить ссылку в профиле юзера
    /// - Parameters:
    ///   - imageData: Изображение в формате Data
    ///   - model: enum - куда загружать фото
    ///   - completion: В случае успеха вернет url - ссылка на изображение и error - nil
    func uploadImage(imageData: Data,
                     uid: String,
                     completion: @escaping (Result<String?, Error>) -> Void) {
        
        let storageRef = Storage.storage().reference().child("users/\(uid)/photos/1")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if let error = error {
                // Failed upload image
                completion(.failure(error))
                return
            } else if metaData == nil {
                
                return
            }
            
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    var userObject = [String: Any]()
                    
                    userObject["imageURLString"] = url!.absoluteString
                    
                    self.userCollectionRef.document(uid).setData(userObject, merge: true) { error in
                        completion(.success(url?.absoluteString))
                    }
                }
            }
        }
    }
}
