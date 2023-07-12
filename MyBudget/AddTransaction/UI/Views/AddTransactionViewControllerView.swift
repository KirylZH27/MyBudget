//
//  AddTransactionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
final class AddTransactionViewControllerView: NiblessView {
    
    let segmentedControll: UISegmentedControl = {
        let segmentArray = ["Расходы","Доходы"]
        let segmentedControll = UISegmentedControl(items: segmentArray)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControll
    }()
    
    let quantityMoneyTextField: UITextField = {
      let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.placeholder = "Br 0"
       textField.tintColor = .black
       textField.backgroundColor = .white
       textField.layer.cornerRadius = 8
       textField.layer.borderWidth = 1
       textField.textAlignment = .center
       textField.font = UIFont(name: "AmericanTypewriter", size: 40)
       return textField
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
 
        layoutElements()
    }
    
    private func layoutElements(){
        layoutSegmentedControll()
        layoutQuantityMoneyTextField()
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
}
