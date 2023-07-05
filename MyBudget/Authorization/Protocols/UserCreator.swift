//
//  UserCreator.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation

protocol UserCreator{
    func createUserIfNeeded(with userId: String, completion: @escaping (Result<Void, Error>) -> Void)
}
