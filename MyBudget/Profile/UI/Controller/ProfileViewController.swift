//
//  ProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
final class ProfileViewController: NiblessViewController {
    
    var contentView: ProfileViewControllerView {
        view as! ProfileViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = ProfileViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    private func addTargets() {
        contentView.editProfileButton.addTarget(self, action: #selector(editProfileButtonWasPressed) , for: .touchUpInside)
        contentView.signOutProfileButton.addTarget(self, action: #selector(signOutProfileButtonWasPressed), for: .touchUpInside)
    }
    
}

extension ProfileViewController {
    @objc private func editProfileButtonWasPressed() {
        print("Изменен")
    }
    @objc private func signOutProfileButtonWasPressed() {
        print("Вышел")
    }
}
