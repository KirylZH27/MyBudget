//
//  ProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: NiblessViewController {
    
    var contentView: ProfileViewControllerView {
        view as! ProfileViewControllerView
    }
    private let appColorGetter: AppColorGetter
    private let signOutNavigationResponder: SignOutNavigationResponder
    
    init(signOutNavigationResponder: SignOutNavigationResponder) {
        self.appColorGetter = UserDefaultAppColorDataSource()
        self.signOutNavigationResponder = signOutNavigationResponder
        super.init()
    }
    
    override func loadView() {
        view = ProfileViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMainColor()
    }
    
    private func setupMainColor(){
        let mainColor = appColorGetter.getMainColor()
        contentView.imageView.backgroundColor = mainColor
        contentView.editProfileButton.backgroundColor = mainColor
        contentView.signOutProfileButton.backgroundColor = mainColor
    }
    
    private func addTargets() {
        contentView.editProfileButton.addTarget(self, action: #selector(editProfileButtonWasPressed) , for: .touchUpInside)
        contentView.signOutProfileButton.addTarget(self, action: #selector(signOutProfileButtonWasPressed), for: .touchUpInside)
    }
    
}

extension ProfileViewController {
    
    @objc private func editProfileButtonWasPressed() {
        print("Изменен")

        let viewController = EditProfileViewController()
        
        viewController.userModel = contentView.userModel
        
        navigationController?.pushViewController(viewController, animated: true)
        
        viewController.completion = { [weak self] userModel in
            self?.contentView.setupUser(userModel: userModel)
        }
    }
    
    @objc private func signOutProfileButtonWasPressed() {
        showAlert(title: "Выход",
                  message: "Хотите выйти из аккаунту?",
                  isCancelButton: true,
                  isOkDestructive: true,
                  okButtonName: "Выход") {
            
            try? Auth.auth().signOut()
            self.signOutNavigationResponder.signOut()
        }
    }
}

