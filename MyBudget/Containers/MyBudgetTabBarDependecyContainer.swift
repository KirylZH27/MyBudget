//
//  MyBudgetTabBarDependecyContainer.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class MyBudgetTabBarDependecyContainer {
    func makeTabBar() -> UITabBarController{
        
        let addTtansactionsViewController = createAddTransactionViewController()
        let bankAccountsViewController = createBankAccountsViewController()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [addTtansactionsViewController, bankAccountsViewController]
        return tabBarController
    }
    
    private func createAddTransactionViewController() -> AddTransactionViewController {
        let viewController = AddTransactionViewController()
        viewController.tabBarItem.title = "Добавить"
        viewController.tabBarItem.image = UIImage(systemName: "plus.circle.fill")
        return viewController
    }
    
    private func createBankAccountsViewController() -> UINavigationController {
        let viewController = BankAccountsViewController ()
        viewController.navigationItem.title = "Счета"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Счета"
        navigationController.tabBarItem.image = UIImage(systemName: "creditcard.circle")
        return navigationController
    }
    
}
