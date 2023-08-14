//
//  AddTransactionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class AddTransactionViewControllerView: NiblessView {
    
    let keyBoard = AddTransactionViewControllerKeyBoardView(frame: .zero)
    
    let segmentedControll: UISegmentedControl = {
        let segmentArray = [TransactionType.expenditure.rawValue, TransactionType.income.rawValue]
        let segmentedControll = UISegmentedControl(items: segmentArray)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.selectedSegmentIndex = 0
        return segmentedControll
    }()
    
    let quantityMoneyTextField: UITextField = {
      let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.placeholder = "Br 0"
       textField.tintColor = AppColors.black.value
       textField.backgroundColor = AppColors.white.value
       textField.layer.cornerRadius = 8
       textField.layer.borderWidth = 1
       textField.textAlignment = .center
       textField.font = UIFont(name: "AmericanTypewriter", size: 40)
       textField.isUserInteractionEnabled = false
       return textField
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColors.white.value
        layoutElements()
    }
    
    private func layoutElements(){
        layoutSegmentedControll()
        layoutQuantityMoneyTextField()
        setViewHierarhies()
        setUpContraints()
    }
    
    private func setViewHierarhies(){
        self.addSubview(keyBoard)
    }
    
    private func layoutSegmentedControll(){
        addSubview(segmentedControll)
        NSLayoutConstraint.activate([
            segmentedControll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
    
    private func layoutQuantityMoneyTextField(){
        addSubview(quantityMoneyTextField)
        NSLayoutConstraint.activate([
            quantityMoneyTextField.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 20),
            quantityMoneyTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            quantityMoneyTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            quantityMoneyTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func setUpContraints(){
        NSLayoutConstraint.activate([
            keyBoard.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyBoard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyBoard.topAnchor.constraint(equalTo: quantityMoneyTextField.bottomAnchor, constant: 10),
            keyBoard.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AddTransactionViewControllerView: DisplayManager {
    func setValue(value: String) {
        self.quantityMoneyTextField.insertText(value)
        
        if value == "-0" {
            return
        }
        
        guard let currentText = quantityMoneyTextField.text else { return }
        
        if currentText.range(of: Locale.current.decimalSeparator ?? ".") == nil {
            self.quantityMoneyTextField.text = currentText.convertTextInDouble().formatterFrom
        }
        
        let newPosition = quantityMoneyTextField.endOfDocument
        quantityMoneyTextField.selectedTextRange = quantityMoneyTextField.textRange(from: newPosition, to: newPosition)
    }
    
    func deletee() {
        self.quantityMoneyTextField.text?.removeAll()
    }
    
    func clear() {
        self.quantityMoneyTextField.text?.removeAll()
        self.quantityMoneyTextField.insertText("0")
    }
}
