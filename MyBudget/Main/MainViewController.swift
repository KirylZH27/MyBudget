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
    private var cancelable = Set<AnyCancellable>()
   
    private var currentAuthorizationNavigationController: UINavigationController?
    
    init(viewModel: MainViewModel,
         tabBarControllerFactory: @escaping () -> UITabBarController,
         transactionWasAddedAnimationViewControllerFactory: @escaping () -> TransactionWasAddedAnimationViewController) {
        
        self.viewModel = viewModel
        self.tabBarControllerFactory = tabBarControllerFactory
        self.transactionWasAddedAnimationViewControllerFactory = transactionWasAddedAnimationViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        presentTabBarController()
    }
    
    private func bindViewModel(){
//        viewModel.isPresentAuthorization.sink { [weak self] isPresentAuthorization in
//            if !isPresentAuthorization  {
//                self?.presentTabBarController()
//            }
//        }.store(in: &cancelable)
        
        viewModel.showTransactionWasAddedAnimation.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                    self?.presentTransactionWasAddedAnimationViewController()
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
    
}
