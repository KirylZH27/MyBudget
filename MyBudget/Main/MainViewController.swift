//
//  MainViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
import FirebaseAuth
import Combine

final class MainViewController: NiblessViewController {
    
    private let viewModel: MainViewModel
    private let tabBarControllerFactory: () -> UITabBarController
    private let transactionWasAddedAnimationViewControllerFactory: () -> TransactionWasAddedAnimationViewController
    private let userAdditionalInfoViewControllerFactory: () -> UserAdditionalInfoViewController
    private let authorizationViewControllerFactory: () -> AuthorizationViewController
    private var cancelable = Set<AnyCancellable>()
    
    init(viewModel: MainViewModel,
         tabBarControllerFactory: @escaping () -> UITabBarController,
         transactionWasAddedAnimationViewControllerFactory: @escaping () -> TransactionWasAddedAnimationViewController,
         authorizationViewControllerFactory: @escaping () -> AuthorizationViewController,
         userAdditionalInfoViewControllerFactory: @escaping () -> UserAdditionalInfoViewController) {
        
        self.viewModel = viewModel
        self.tabBarControllerFactory = tabBarControllerFactory
        self.transactionWasAddedAnimationViewControllerFactory = transactionWasAddedAnimationViewControllerFactory
        self.authorizationViewControllerFactory = authorizationViewControllerFactory
        self.userAdditionalInfoViewControllerFactory = userAdditionalInfoViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViewModel()
        viewModel.checkAuthorization()
    }
    
    private func bindViewModel(){
        viewModel.isPresentAuthorization.sink { [weak self] isPresentAuthorization in
            if !isPresentAuthorization  {
                self?.hideAuthorizationViewController()
                self?.presentTabBarController()
            } else {
                self?.presentAuthorizationViewController()
            }
        }.store(in: &cancelable)
        
        viewModel.showTransactionWasAddedAnimation.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                    self?.presentTransactionWasAddedAnimationViewController()
            }
        }.store(in: &cancelable)
        
        viewModel.isPresentUserAdditionalInfo.sink{ [weak self] isPresentUserAdditionalInfo in
            if isPresentUserAdditionalInfo {
                self?.hideAuthorizationViewController()
                self?.showUserAdditionalInfoViewController()
            } else {
                self?.hideUserAdditionalInfoViewController()
                self?.presentTabBarController()
            }
        }.store(in: &cancelable)
    }

    private func presentTabBarController() {
        let tabBarController = tabBarControllerFactory()
        addFullScreen(childViewController: tabBarController)
    }
    
    private func presentTransactionWasAddedAnimationViewController() {
        let transactionAnimationController = transactionWasAddedAnimationViewControllerFactory()
        transactionAnimationController.contentView.isUserInteractionEnabled = false
        addFullScreen(childViewController: transactionAnimationController)
    }
    
    private func presentAuthorizationViewController(){
        let authorizationViewController = authorizationViewControllerFactory()
        addFullScreen(childViewController: authorizationViewController)
    }
    
    private func hideAuthorizationViewController(){
        let authorizationViewController = children.filter{ $0 is AuthorizationViewController}.first as? AuthorizationViewController
        remove(childViewController: authorizationViewController)
    }
    
    private func hideTabBarController(){
        let tabBarController = children.filter{ $0 is UITabBarController}.first as? UITabBarController
        remove(childViewController: tabBarController)
    }
    
    private func showUserAdditionalInfoViewController(){
        let userAdditionalInfoViewController = userAdditionalInfoViewControllerFactory()
        addFullScreen(childViewController: userAdditionalInfoViewController)
    }
    
    private func hideUserAdditionalInfoViewController(){
        let userAdditionalInfoViewController = children.filter{ $0 is UserAdditionalInfoViewController}.first as? UserAdditionalInfoViewController
        remove(childViewController: userAdditionalInfoViewController)
    }
}

