//
//  UserStore.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
protocol UserStore {
    func checkIfUserExist(by userID: String, completion: @escaping (Bool)->Void)
    func create(user: UserModel, completion: @escaping (Result<Void, Error>)->Void)
    func delete(user: UserModel, completion: @escaping (Result<Void, Error>)->Void)
}
