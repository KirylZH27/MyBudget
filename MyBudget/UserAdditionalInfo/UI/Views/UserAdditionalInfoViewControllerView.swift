//
//  UserAdditionalInfoViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import UIKit

final class UserAdditionalInfoViewControllerView: NiblessView {
    
    // MARK: - IBOutlets
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "User name"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.tintColor, for: .normal)
        btn.backgroundColor = .red
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInit()
        setupConstraints()
    }
    
    // MARK: - Private methods
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
