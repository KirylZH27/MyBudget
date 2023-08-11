//
//  UserAdditionalInfoViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import UIKit

final class UserAdditionalInfoViewControllerView: NiblessView {
    
    let userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "User name"
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInit()
        setupConstraints()
    }
    
    private func setupInit() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        addSubview(userNameTextField)
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            userNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            saveButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
