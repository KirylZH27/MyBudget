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
    
    init(viewModel: MainViewModel,
         tabBarControllerFactory: @escaping () -> UITabBarController) {
        self.viewModel = viewModel
        self.tabBarControllerFactory = tabBarControllerFactory
        super.init()
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presentTabBarController()
        view.backgroundColor = .red
    }
    
    private func presentTabBarController() {
        let tabBarController = tabBarControllerFactory()
        addFullScreen(childViewController: tabBarController)
    }
}
