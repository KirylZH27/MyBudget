//
//  TransactionWasAddedAnimationViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 28.07.23.
//

import UIKit

final class TransactionWasAddedAnimationViewControllerView: NiblessView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        alpha = 0.5
    }
}
