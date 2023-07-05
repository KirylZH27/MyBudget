//
//  ProfileViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
final class ProfileViewControllerView: NiblessView {
   
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = AppColors.green.value
        return imageView
    }()
    
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Кирилл"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter", size: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
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

    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kirill27@mail.com"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter", size: 25)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
   
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Изменить профиль", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let signOutProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Выход из аккаунта", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutElements()
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutImageView()
        layoutNameSignatureLabel()
        layoutNamelabel()
        layoutEmailSignatureLabel()
        layoutEmailLabel()
        layoutEditProfileButton()
        layoutSignOutProfileButton()
    }
    
    
    private func layoutScrollView(){
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutImageView(){
        scrollView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutNameSignatureLabel(){
        scrollView.addSubview(nameSignatureLabel)
        NSLayoutConstraint.activate([
            nameSignatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            nameSignatureLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            nameSignatureLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
        private func layoutNamelabel(){
            scrollView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameSignatureLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
         //   nameLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutEmailSignatureLabel(){
        scrollView.addSubview(emailSignatureLabel)
        NSLayoutConstraint.activate([
            emailSignatureLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            emailSignatureLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            emailSignatureLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutEmailLabel(){
        scrollView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: emailSignatureLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
        //    emailLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutEditProfileButton() {
        scrollView.addSubview(editProfileButton)
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 75),
            editProfileButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 72),
            editProfileButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -72),
        //    editProfileButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10)
            editProfileButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    
    private func layoutSignOutProfileButton() {
        scrollView.addSubview(signOutProfileButton)
        NSLayoutConstraint.activate([
            signOutProfileButton.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 35),
            signOutProfileButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 100),
            signOutProfileButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -100),
            signOutProfileButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10),
            signOutProfileButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
