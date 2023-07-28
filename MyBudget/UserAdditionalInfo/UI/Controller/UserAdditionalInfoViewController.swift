//
//  UserAdditionalInfoViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import UIKit
import FirebaseAuth

final class UserAdditionalInfoViewController: NiblessViewController {
    
    // MARK: - Private properties
    private let viewModel: UserAdditionalInfoViewModel
    //    private let hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder?
    
    // MARK: - Public properties
    var contentView: UserAdditionalInfoViewControllerView {
        view as! UserAdditionalInfoViewControllerView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        hideAuthorizationNavigationResponder.hideAuthorization()
    }
    
    init(viewModel: UserAdditionalInfoViewModel) {
        self.viewModel = viewModel
        //        self.hideAuthorizationNavigationResponder = hideAuthorizationNavigationResponder
        
        super.init()
    }
    
    override func loadView() {
        view = UserAdditionalInfoViewControllerView()
    }
    
    
    // MARK: - IBActions
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
                self?.showMainVC()
            }
        }
    }
    
    // MARK: - Private methods
    private func setupInit() {
        contentView.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    private func showMainVC() {
        let vc = makeMainViewController()
        
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func makeMainViewController() -> MainViewController {
        let viewModel = MainViewModel()
        
        let tabBarControllerFactory = {
            MyBudgetTabBarDependecyContainer(sharedMainViewModel: viewModel).makeTabBar()
        }
        
        let transactionWasAddedAnimationViewControllerFactory = {
            TransactionWasAddedAnimationViewController()
        }
        
        let viewController = MainViewController(viewModel: viewModel,
                                                tabBarControllerFactory: tabBarControllerFactory, transactionWasAddedAnimationViewControllerFactory: transactionWasAddedAnimationViewControllerFactory)
        
        return viewController
    }
    
}
