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
    
    
    private let appColorGetter: AppColorGetter
    
    private let transactionDescriptionViewControllerFactory: (TransactionType, String) -> TransactionDescriptionViewController
    private var transactionType: TransactionType = .expenditure
    
    var contentView: AddTransactionViewControllerView {
        view as! AddTransactionViewControllerView
    }
    
    init(transactionDescriptionViewControllerFactory: @escaping (TransactionType, String) -> TransactionDescriptionViewController) {
        self.transactionDescriptionViewControllerFactory = transactionDescriptionViewControllerFactory
        self.appColorGetter = UserDefaultAppColorDataSource()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AddTransactionViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMainColor()
    }
    
    private func setupMainColor(){
        let mainColor = appColorGetter.getMainColor()
        contentView.keyBoard.saveTransactionButton.backgroundColor = mainColor
    /*    contentView.keyBoard.zeroStackView.arrangedSubviews.forEach { arrangeView in
            let buttonView = arrangeView as? KeyBoardButton
            buttonView?.backgroundColor = mainColor
        }
     */
        contentView.keyBoard.mainStackView.arrangedSubviews.forEach { arrangeView in
            let stackView = arrangeView as? UIStackView
            stackView?.arrangedSubviews.forEach({ buttonArrangeView in
                let buttonView = buttonArrangeView as? KeyBoardButton
                buttonView?.backgroundColor = mainColor
            })
        }
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
    private func addTargets(){
        contentView.keyBoard.saveTransactionButton.addTarget(self, action: #selector(saveTransactionButtonWasPressed) , for: .touchUpInside)
        contentView.segmentedControll.addTarget(self, action: #selector(transactionTypeWasChanged(_:)), for: .valueChanged)
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

extension AddTransactionViewController {
   @objc private func saveTransactionButtonWasPressed(){
       guard let transitionValue = contentView.quantityMoneyTextField.text else { return }
       let transactionDescriptionViewController = transactionDescriptionViewControllerFactory(transactionType, transitionValue)
       present(transactionDescriptionViewController, animated: true)
    }
    
    @objc func transactionTypeWasChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: transactionType = .expenditure
            case 1: transactionType = .income
            default: break
        }
    }
}
