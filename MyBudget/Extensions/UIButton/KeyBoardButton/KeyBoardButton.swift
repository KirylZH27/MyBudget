//
//  KeyBoardButton.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 12.07.23.
//

import UIKit

struct ModelKeyBoardButton {
    let title: String
    let backgroundColor: UIColor
    let titleColor: UIColor
    let font: UIFont?
}

final class KeyBoardButton: UIButton {
    let typeButton: KeyBoardSymbol
    
    init(model: ModelKeyBoardButton, type: KeyBoardSymbol) {
        self.typeButton = type
        super.init(frame: .zero)
        setConfiguration(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfiguration(model: ModelKeyBoardButton){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = model.backgroundColor
        self.contentMode = .scaleAspectFit
        self.setTitle(model.title, for: state)
        self.setTitleColor(model.titleColor, for: .normal)
        self.titleLabel?.font = model.font
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 4
    }
}


