//
//  UserSignOut.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 6.07.23.
//

import Foundation

public protocol UserSignOut{
    typealias Result = Swift.Result<Void, Error>
    func signOut(completion: @escaping (Result)->Void)
}
