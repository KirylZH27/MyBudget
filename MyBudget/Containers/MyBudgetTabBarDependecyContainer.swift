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
        let analiticsViewController = createAnaliticsViewController()
        let settingsViewController = createSettingsViewController()
        let profileViewController = createProfileViewController()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [addTtansactionsViewController, bankAccountsViewController, analiticsViewController, settingsViewController, profileViewController]
        return tabBarController
    }
    
    private func createAddTransactionViewController() -> AddTransactionViewController {
        let viewController = AddTransactionViewController()
        viewController.tabBarItem.title = "Добавить"
        viewController.tabBarItem.image = UIImage(systemName: "plus.circle.fill")
        return viewController
    }
    
    private func createBankAccountsViewController() -> UINavigationController {
        let viewModel = createBankAccountViewModel()
        let viewController = BankAccountsViewController(viewModel: viewModel)
        viewController.navigationItem.title = "Счета"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Счета"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "creditcard.circle")
        return navigationController
    }
    
    private func createBankAccountViewModel() -> BankAccountViewModel{
        let bankAccountGetter = BankAccountRealmManager()
        let viewModel = BankAccountViewModel(bankAccountGetter: bankAccountGetter)
        return viewModel
    }
    
    private func createAnaliticsViewController() -> AnaliticsViewController {
        let viewController = AnaliticsViewController()
        viewController.tabBarItem.title = "Аналитика"
        viewController.tabBarItem.image = UIImage(systemName: "chart.pie")
        return viewController
    }
    
    private func createSettingsViewController() -> UINavigationController {
        let viewController = SettingsViewController()
        viewController.navigationItem.title = "Настройки"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Настройки"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "gear")
        return navigationController
    }
    
    private func createProfileViewController() -> UINavigationController {
        let viewController = ProfileViewController()
        viewController.navigationItem.title = "Профиль"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Профиль"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        return navigationController
    }
    
}
