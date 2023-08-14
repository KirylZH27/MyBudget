//
//  MyBudgetTabBarDependecyContainer.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class MyBudgetTabBarDependecyContainer {
    
    private let sharedMainViewModel: MainViewModel
    
    init(sharedMainViewModel: MainViewModel) {
        self.sharedMainViewModel = sharedMainViewModel
    }
    
    func makeTabBar() -> UITabBarController{
        let addTtansactionsViewController = createAddTransactionViewController()
        let bankAccountsViewController = createBankAccountsViewController()
        let analiticsViewController = createAnaliticsViewController()
        let settingsViewController = createSettingsViewController()
        let profileViewController = createProfileViewController(signOutNavigationResponder: sharedMainViewModel)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [addTtansactionsViewController, bankAccountsViewController, analiticsViewController, settingsViewController, profileViewController]
        return tabBarController
    }
    
    private func createAddTransactionViewController() -> AddTransactionViewController {
        let transactionDescriptionViewControllerFactory = { type, value in
            self.createTransactionDescriptionViewController(transactionType: type, transactionValue: value)
        }
        let viewController = AddTransactionViewController(transactionDescriptionViewControllerFactory: transactionDescriptionViewControllerFactory)
        viewController.tabBarItem.title = "Добавить"
        viewController.tabBarItem.image = UIImage(systemName: "plus.circle.fill")
        return viewController
    }
    
    private func createTransactionDescriptionViewController(transactionType: TransactionType, transactionValue: String) -> TransactionDescriptionViewController{
        let bankAccountGetter = BankAccountRealmManager()
        let transactionCreator = TransactionRealmManager()
        let viewModel = TransactionDescriptionViewModel(bankAccountGetter: bankAccountGetter, transactionCreator: transactionCreator)
        
        let viewController = TransactionDescriptionViewController(viewModel: viewModel, transactionValue: transactionValue, transactionType: transactionType, transactionWasAddedAnimationNavigationResponder: sharedMainViewModel)
        return viewController
    }
    
    private func createBankAccountsViewController() -> UINavigationController {
        let viewModel = createBankAccountViewModel()
        let addBankAccountViewControllerFactory = {
            self.createAddBankAccountViewController()
        }
        let accountDescriptionViewControllerFactory = { bankAccount in
            self.createAccountDescriptionViewController(bankAccount: bankAccount)
        }
        let viewController = BankAccountsViewController(viewModel: viewModel, addBankAccountViewControllerFactory: addBankAccountViewControllerFactory, accountDescriptionViewControllerFactory: accountDescriptionViewControllerFactory)
        
        viewController.navigationItem.title = "Счета"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Счета"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "creditcard.circle")
        return navigationController
    }
    
    private func createAddBankAccountViewController() -> AddBankAccountViewController {
        let bankAccountCreator = BankAccountRealmManager()
        let viewModel = AddBankAccountViewModel(bankAccountCreator: bankAccountCreator)
        let viewController = AddBankAccountViewController(viewModel: viewModel)
        return viewController
    }
    
    private func createAccountDescriptionViewController(bankAccount: BankAccount) -> AccountDescriptionViewController {
       let transactionGetter = TransactionRealmManager()
       let transactionDeleter = TransactionRealmManager()
        let viewModel = AccountDescriptionViewModel(transactionGetter: transactionGetter, bankAccount: bankAccount, transactionDeleter: transactionDeleter)
        let viewController = AccountDescriptionViewController(viewModel: viewModel)
        return viewController
    }
    
    private func createBankAccountViewModel() -> BankAccountViewModel{
        let bankAccountGetter = BankAccountRealmManager()
        let transactionGetter = TransactionRealmManager()
        let bankAccountDeleter = BankAccountRealmManager()
        let viewModel = BankAccountViewModel(bankAccountGetter: bankAccountGetter, bankAccountDeleter: bankAccountDeleter, transactionGetter: transactionGetter)
        return viewModel
    }
    
    private func createAnaliticsViewController() -> AnaliticsViewController {
        let transactionGetter = TransactionRealmManager()
        let viewModel = AnaliticsViewModel(transactionGetter: transactionGetter)
        let viewController = AnaliticsViewController(viewModel: viewModel)
        viewController.tabBarItem.title = "Аналитика"
        viewController.tabBarItem.image = UIImage(systemName: "chart.pie")
        return viewController
    }
    
    private func createSettingsViewController() -> UINavigationController {
        let appColorManager = UserDefaultAppColorDataSource()
        let darkModeManager = UserDefaultDarkModeStateDataSource()
        let settingViewModel = SettingsViewModel(appColorSetter: appColorManager, appColorGetter: appColorManager, darkModeSetter: darkModeManager, darkModeGetter: darkModeManager)
        let viewController = SettingsViewController(viewModel: settingViewModel)
        viewController.navigationItem.title = "Настройки"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Настройки"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "gear")
        return navigationController
    }
    
    private func createProfileViewController(signOutNavigationResponder: SignOutNavigationResponder) -> UINavigationController {
        let viewController = ProfileViewController(signOutNavigationResponder: signOutNavigationResponder)
        viewController.navigationItem.title = "Профиль"
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = "Профиль"
        navigationController.navigationBar.tintColor = .black
        navigationController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        return navigationController
    }
}
