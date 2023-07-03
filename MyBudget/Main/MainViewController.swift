//
//  MainViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
final class MainViewController: NiblessViewController {
   
    
    private let viewModel: MainViewModel
    private let tabBarControllerFactory: () -> UITabBarController
    private let authorizationViewControllerFactory: () -> AuthorizationViewController
    
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
     //   presentAuthorizationViewController()
      presentTabBarController()
        view.backgroundColor = .red
    }
    
    private func presentTabBarController() {
        let tabBarController = tabBarControllerFactory()
        addFullScreen(childViewController: tabBarController)
    }
    
    private func presentAuthorizationViewController() {
        let authorizationViewController = authorizationViewControllerFactory()
        addFullScreen(childViewController: authorizationViewController)
    }
    
}
