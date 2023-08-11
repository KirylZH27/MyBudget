//
//  AuthorizationViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import UIKit
final class AuthorizationViewControllerView: NiblessView {
    
    private let titleAppLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Budget"
        label.numberOfLines = 0
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        imageView.tintColor = AppColors.green.value
        return imageView
    }()
    
    let continueWithGoogleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Continue with Google", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        layoutElements()
    }
    
    private func layoutElements(){
        layoutImageView()
        layoutContinueWithGoogleButton()
        layoutTitleAppLabel()
    }
    
    private func layoutTitleAppLabel(){
        addSubview(titleAppLabel)
        NSLayoutConstraint.activate([
            titleAppLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
            titleAppLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titleAppLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
    
    private func layoutImageView(){
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutContinueWithGoogleButton(){
        addSubview(continueWithGoogleButton)
        NSLayoutConstraint.activate([
            continueWithGoogleButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 175),
            continueWithGoogleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            continueWithGoogleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
