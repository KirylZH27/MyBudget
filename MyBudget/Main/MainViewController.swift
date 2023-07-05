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
    private let authorizationViewControllerFactory: () -> AuthorizationViewController
    private var cancelable = Set<AnyCancellable>()
   
    private var currentAuthorizationNavigationController: UINavigationController?
    
    init(viewModel: MainViewModel,
         tabBarControllerFactory: @escaping () -> UITabBarController,
         authorizationViewControllerFactory: @escaping () -> AuthorizationViewController) {
        self.viewModel = viewModel
        self.tabBarControllerFactory = tabBarControllerFactory
        self.authorizationViewControllerFactory = authorizationViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        checkAuthorization()
        view.backgroundColor = .red
    }
    
    private func bindViewModel(){
        viewModel.isPresentAuthorization.sink { [weak self] isPresentAuthorization in
            if !isPresentAuthorization  {
                self?.hideAuthorizationViewController()
                self?.presentTabBarController()
            }
        }.store(in: &cancelable)
    }

    
    
    private func checkAuthorization() {
        if Auth.auth().currentUser != nil {
            presentTabBarController()

        } else {
            presentAuthorizationViewController()
        }
    }
    
    private func presentTabBarController() {
        let tabBarController = tabBarControllerFactory()
        addFullScreen(childViewController: tabBarController)
    }
    
    private func presentAuthorizationViewController() {
        let authorizationViewController = authorizationViewControllerFactory()
        let navigationController = UINavigationController(rootViewController: authorizationViewController)
        addFullScreen(childViewController: navigationController)
        self.currentAuthorizationNavigationController = navigationController
    }
    
    
    private func hideAuthorizationViewController(){
        guard let currentAuthorizationNavigationController else { return }
        remove(childViewController: currentAuthorizationNavigationController)
        self.currentAuthorizationNavigationController = nil
    }
}
