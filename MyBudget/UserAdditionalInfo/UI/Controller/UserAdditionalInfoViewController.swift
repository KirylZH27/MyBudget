//
//  UserAdditionalInfoViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import UIKit
import FirebaseAuth

final class UserAdditionalInfoViewController: NiblessViewController {
    
    private let viewModel: UserAdditionalInfoViewModel
    private let hideUserAdditionalInfoNavigationResponder: HideUserAdditionalInfoNavigationResponder
    
    var contentView: UserAdditionalInfoViewControllerView {
        view as! UserAdditionalInfoViewControllerView
    }
    
    override func loadView() {
        view = UserAdditionalInfoViewControllerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInit()
    }
    
    init(viewModel: UserAdditionalInfoViewModel, hideUserAdditionalInfoNavigationResponder: HideUserAdditionalInfoNavigationResponder) {
        self.viewModel = viewModel
        self.hideUserAdditionalInfoNavigationResponder = hideUserAdditionalInfoNavigationResponder
        super.init()
    }
    
    @objc private func saveButtonAction() {
        guard
            let user = Auth.auth().currentUser,
            let userEmail = user.email
        else { return }
        
        guard
            let userName = contentView.userNameTextField.text,
            !userName.isEmpty
        else {
            showAlert(title: "Ошибка",
                      message: "Заполните имя юзера")
            
            return
        }
        
        let userStore = FirebaseUserStore()
        let userModel = UserModel(email: userEmail,
                                  name: userName,
                                  imageURLString: nil,
                                  id: user.uid)
        
        userStore.create(user: userModel) { [weak self] result in
            switch result {
            case .failure(let error):
                ()
                // FIXME: show error
            case .success(_):
                    self?.hideUserAdditionalInfoNavigationResponder.hideUserAdditionalInfo()
            }
        }
    }
    
    private func setupInit() {
        contentView.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
}
