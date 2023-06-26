//
//  MyBudgetDependencyContainer.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class MyBudgetDependencyContainer {
    func makeMainViewController () -> MainViewController {
        let viewModel = MainViewModel()
        
        let tabBarControllerFactory = {
            self.createTabBarController()
        }
        
        let viewController = MainViewController(viewModel: viewModel, tabBarControllerFactory: tabBarControllerFactory)
        return viewController
    }
    
    private func createTabBarController() -> UITabBarController {
        MyBudgetTabBarDependecyContainer().makeTabBar()
    }
}
