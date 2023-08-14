//
//  AddBankAccountViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import UIKit

final class AddBankAccountViewControllerView: NiblessView {
    
    private let appColorGetter: AppColorGetter
    
    private let navigationTittleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        label.text = "Добавить счет"
        label.textColor = AppColors.black.value
        label.textAlignment = .center
        return label
    }()
    
    private let nameAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.text = "Название счета"
        label.textColor = AppColors.black.value
        label.textAlignment = .left
        return label
    }()
    
    let nameAccountTextField: UITextField = {
      let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.placeholder = "Добавить название"
        textField.tintColor = AppColors.black.value
        textField.backgroundColor = AppColors.white.value
       textField.layer.cornerRadius = 8
       textField.layer.borderWidth = 1
       textField.textAlignment = .center
       textField.font = UIFont(name: "AmericanTypewriter", size: 19)
       return textField
   }()
    
    private let currentBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.textColor = AppColors.black.value
        label.text = "Текущий баланс"
        label.textAlignment = .left
        return label
    }()
    
    let currentBalanceTextField: UITextField = {
      let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.placeholder = "Введите сумму средств на счете"
       textField.tintColor = AppColors.black.value
       textField.backgroundColor = AppColors.white.value
       textField.layer.cornerRadius = 8
       textField.layer.borderWidth = 1
       textField.textAlignment = .center
       textField.font = UIFont(name: "AmericanTypewriter", size: 19)
       return textField
   }()
    
    lazy var addAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.getMainColor()
        button.setTitle("Добавить", for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 22)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let accountPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        
        layoutElements()
    }
    
    private func layoutElements() {
        layoutNavigationTittleLabel()
        layoutNameAccountLabel()
        layoutNameAccountTextField()
        layoutCurrentBalanceLabel()
        layoutCurrentBalanceTextField()
        layoutaddAccountButton()
        layoutAccountPickerView()
    }
    
    private func layoutNavigationTittleLabel(){
        addSubview(navigationTittleLabel)
        NSLayoutConstraint.activate([
            navigationTittleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            navigationTittleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            navigationTittleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutNameAccountLabel(){
        addSubview(nameAccountLabel)
        NSLayoutConstraint.activate([
            nameAccountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 120),
            nameAccountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameAccountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutNameAccountTextField(){
        addSubview(nameAccountTextField)
        NSLayoutConstraint.activate([
            nameAccountTextField.topAnchor.constraint(equalTo: nameAccountLabel.bottomAnchor, constant: 10),
            nameAccountTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameAccountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameAccountTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func layoutCurrentBalanceLabel(){
        addSubview(currentBalanceLabel)
        NSLayoutConstraint.activate([
            currentBalanceLabel.topAnchor.constraint(equalTo: nameAccountTextField.bottomAnchor, constant: 40),
            currentBalanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentBalanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func layoutCurrentBalanceTextField(){
        addSubview(currentBalanceTextField)
        NSLayoutConstraint.activate([
            currentBalanceTextField.topAnchor.constraint(equalTo: currentBalanceLabel.bottomAnchor, constant: 10),
            currentBalanceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentBalanceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            currentBalanceTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func layoutaddAccountButton() {
        addSubview(addAccountButton)
        NSLayoutConstraint.activate([
            addAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            addAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            addAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addAccountButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutAccountPickerView(){
        addSubview(accountPickerView)
        NSLayoutConstraint.activate([
            accountPickerView.topAnchor.constraint(equalTo: currentBalanceLabel.bottomAnchor, constant: 70),
            accountPickerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            accountPickerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
