//
//  EditProfileViewConttrollerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 3.07.23.
//

import UIKit

final class EditProfileViewConttrollerView: NiblessView {
    
    private let appColorGetter: AppColorGetter
    
     lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
         imageView.tintColor = appColorGetter.getMainColor()
         imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
     let nameTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите новое имя"
        textField.tintColor = AppColors.black.value
        textField.backgroundColor = AppColors.white.value
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        return textField
    }()
    
     let emailTextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите новый email"
        textField.tintColor = AppColors.black.value
        textField.backgroundColor = AppColors.white.value
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        return textField
    }()
    
    lazy var saveNewProfileInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.getMainColor()
        button.setTitle("Сохранить изменения", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        layoutElements()
    }
    
    private func layoutElements(){
        layoutImageView()
        layoutNameTextField()
        layoutEmailTextField()
        layoutSaveNewProfileInfoButton()
    }
    
    private func layoutImageView(){
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutNameTextField(){
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutEmailTextField(){
        addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutSaveNewProfileInfoButton() {
        addSubview(saveNewProfileInfoButton)
        NSLayoutConstraint.activate([
            saveNewProfileInfoButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 70),
            saveNewProfileInfoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72),
            saveNewProfileInfoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -72),
            saveNewProfileInfoButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
