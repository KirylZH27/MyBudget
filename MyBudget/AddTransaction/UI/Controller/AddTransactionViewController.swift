//
//  AddTransactionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

enum TransactionType: String {
    case income = "Доходы"
    case expenditure = "Расходы"
}

final class AddTransactionViewController: NiblessViewController {
    
    
    var contentView: AddTransactionViewControllerView {
        view as! AddTransactionViewControllerView
    }
    override func loadView() {
        super.loadView()
        view = AddTransactionViewControllerView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    private func setNumber(type: KeyBoardSymbol) {
        let number = type.rawValue
        let currentText = contentView.quantityMoneyTextField.text ?? ""
        contentView.quantityMoneyTextField.text = currentText + number
    }
    
    private func backspaceButtonWasPressed(){
        let currentText = contentView.quantityMoneyTextField.text ?? ""
        guard !currentText.isEmpty else { return }
        let newText = currentText.dropLast(1)
        contentView.quantityMoneyTextField.text = String(newText)
        
    }
    
    private func decimalButtonWasPressed(){
        let currentText = contentView.quantityMoneyTextField.text ?? ""
        let character: Character = "."
        guard !currentText.isEmpty else {
            let decimalValue = "0" + String(character)
            contentView.quantityMoneyTextField.text = decimalValue
            return }
        
        guard !currentText.contains(character) else { return }
        contentView.quantityMoneyTextField.text = currentText + String(character)
        
    }
    
    private func setupDelegates() {
        contentView.keyBoard.delegate = self
    }
    
}
extension AddTransactionViewController: KeyBoardDelegate {
        func onAction(type: KeyBoardSymbol) {
            switch type {
                case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
                    setNumber(type: type)
                case .backspace:
                    backspaceButtonWasPressed()
                case .decimal:
                    decimalButtonWasPressed()
        }
    }
}
