//
//  ProfileViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
import FirebaseAuth
import SDWebImage

final class ProfileViewControllerView: NiblessView {
   
    var userModel: UserModel?
    private let appColorGetter: AppColorGetter
   
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = appColorGetter.getMainColor()
        return imageView
    }()
    
    private let nameSignatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Имя пользователя:"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.textColor = AppColors.black.value
        label.textAlignment = .left
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter", size: 25)
        label.textColor = AppColors.black.value
        label.textAlignment = .left
        return label
    }()
    
    private let emailSignatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email пользователя:"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
        label.textColor = AppColors.black.value
        label.textAlignment = .left
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter", size: 25)
        label.textColor = AppColors.black.value
        label.textAlignment = .left
        return label
    }()
   
    lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.getMainColor()
        button.setTitle("Изменить профиль", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var signOutProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = appColorGetter.getMainColor()
        button.setTitle("Выход из аккаунта", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        layoutElements()
        setupInit()
    }
    
    private func setupInit() {
        guard let user = Auth.auth().currentUser else { return }

        let userStore = FirebaseUserStore()

        userStore.getUser(uid: user.uid) { [weak self] result in
            switch result {
            case .failure(let error):
                ()
            case .success(let userModel):
                self?.userModel = userModel
                self?.setupUser(userModel: userModel)
            }
        }
    }
    
    func setupUser(userModel: UserModel) {
        nameLabel.text = userModel.name
        emailLabel.text = userModel.email
        
        let url = URL(string: userModel.imageURLString ?? "")
        let defaultImage = UIImage(systemName: "person.fill")
        
        imageView.sd_setImage(with: url,
                              placeholderImage: defaultImage)
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
            emailLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func layoutEditProfileButton() {
        scrollView.addSubview(editProfileButton)
        NSLayoutConstraint.activate([
            editProfileButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 75),
            editProfileButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 72),
            editProfileButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -72),
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
