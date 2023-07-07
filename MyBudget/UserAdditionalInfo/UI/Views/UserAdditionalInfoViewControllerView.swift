//
//  UserAdditionalInfoViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import UIKit
final class UserAdditionalInfoViewControllerView: NiblessView {
    
    
    private let nameSignatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя пользователя:"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите свое имя"
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.textAlignment = .left
        textField.font = UIFont(name: "AmericanTypewriter", size: 22)
        return textField
    }()
    
    private let emailSignatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email пользователя:"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите свой email"
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.textAlignment = .left
        textField.font = UIFont(name: "AmericanTypewriter", size: 22)
        return textField
    }()
    
    let saveProfileInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Сохранить информацию", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        layoutElements()
    }
    
    
    private func layoutElements(){
        layoutNameSignatureLabel()
        layoutNameTextField()
        layoutEmailSignatureLabel()
        layoutEmailTextField()
        layoutSaveProfileInfoButton()
    }
    
    private func layoutNameSignatureLabel(){
        addSubview(nameSignatureLabel)
        NSLayoutConstraint.activate([
            nameSignatureLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            nameSignatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameSignatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutNameTextField(){
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameSignatureLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutEmailSignatureLabel(){
        addSubview(emailSignatureLabel)
        NSLayoutConstraint.activate([
            emailSignatureLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailSignatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailSignatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutEmailTextField(){
        addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailSignatureLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutSaveProfileInfoButton(){
        addSubview(saveProfileInfoButton)
        NSLayoutConstraint.activate([
            saveProfileInfoButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60),
            saveProfileInfoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72),
            saveProfileInfoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -72),
            saveProfileInfoButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setUserInformation(profile: UserModel) {
        nameTextField.text = profile.name
        emailTextField.text = profile.email
    }
}
