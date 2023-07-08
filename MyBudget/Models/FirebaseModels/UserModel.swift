//
//  UserModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import Foundation
import Firebase

class UserModel: Codable {
    
    let email: String
    var name: String
    var imageURLString: String?
    let id: String
    
    init(email: String,
         name: String,
         imageURLString: String? = nil,
         id: String) {
        
        self.email = email
        self.name = name
        self.imageURLString = imageURLString
        self.id = id
    }
    
    init(userProfile: UserModel) {
        self.email = userProfile.email
        self.name = userProfile.name
        self.imageURLString = userProfile.imageURLString
        self.id = userProfile.id
    }
    
    convenience init?(document: [String: Any]?) {
        guard
            let dic = document,
            JSONSerialization.isValidJSONObject(dic)
        else {
            print("\nERROR create init in \(#file),\n\(#function),\n\(#line): error: invalid json\n")
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dic as Any, options: [])
            let userProfile = try JSONDecoder().decode(UserModel.self, from: data)
            
            self.init(userProfile: userProfile)
        } catch (let error) {
            print("\nERROR create init in \(#file),\n\(#function),\n\(#line): error: \(error.localizedDescription)\n")
            return nil
        }
    }
    
}
