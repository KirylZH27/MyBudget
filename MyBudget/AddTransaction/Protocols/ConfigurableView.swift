//
//  ConfigurableView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import Foundation

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}
