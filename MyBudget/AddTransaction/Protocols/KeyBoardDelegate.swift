//
//  KeyBoardDelegate.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

protocol KeyBoardDelegate: AnyObject {
    
    func onAction(type: KeyBoardSymbol)
}
