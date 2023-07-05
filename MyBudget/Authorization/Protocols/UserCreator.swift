//
//  UserCreator.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation

protocol UserCreator{
    func createUserIfNeeded(with user: UserModel, completion: @escaping (Result<Void, Error>) -> Void)
}
