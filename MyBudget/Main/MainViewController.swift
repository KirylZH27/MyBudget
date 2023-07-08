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
    private var cancelable = Set<AnyCancellable>()
   
    private var currentAuthorizationNavigationController: UINavigationController?
    
    init(viewModel: MainViewModel,
         tabBarControllerFactory: @escaping () -> UITabBarController) {
        
        self.viewModel = viewModel
        self.tabBarControllerFactory = tabBarControllerFactory
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
    }

    
    private func presentTabBarController() {
        let tabBarController = tabBarControllerFactory()
        addFullScreen(childViewController: tabBarController)
    }

}
