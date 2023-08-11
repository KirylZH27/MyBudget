//
//  MyBudgetDependencyContainer.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
import Firebase
import FirebaseAuth

final class MyBudgetDependencyContainer {
    
    private let sharedWindow: UIWindow
    private let navigationController = UINavigationController()
    
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    func makeMainViewController() -> MainViewController {
        let userStore = FirebaseUserStore()
        let viewModel = MainViewModel(userStore: userStore)
        
        let tabBarControllerFactory = {
            self.createTabBarController(mainViewModel: viewModel)
        }
        
        let authorizationViewControllerFactory = {
            self.createAuthorizationViewController(hideUserAdditionalInfoNavigationResponder: viewModel, showUserAdditionalInfoNavigationResponder: viewModel)
        }
        
        let userAdditionalInfoViewControllerFactory = {
            self.createUserAdditionalInfoViewController(hideUserAdditionalInfoNavigationResponder: viewModel)
        }
        
        let transactionWasAddedAnimationViewControllerFactory = {
            TransactionWasAddedAnimationViewController()
        }
        
        let viewController = MainViewController(viewModel: viewModel,
                                                tabBarControllerFactory: tabBarControllerFactory,
                                                transactionWasAddedAnimationViewControllerFactory: transactionWasAddedAnimationViewControllerFactory,
                                                authorizationViewControllerFactory: authorizationViewControllerFactory,
                                                userAdditionalInfoViewControllerFactory: userAdditionalInfoViewControllerFactory)
        return viewController
    }
    
    private func createAuthorizationViewController(hideUserAdditionalInfoNavigationResponder: HideAuthorizationNavigationResponder, showUserAdditionalInfoNavigationResponder: ShowUserAditionalInfoNavigationResponder) -> AuthorizationViewController {
        let viewModel = createAuthorizationViewModel()
        
        let viewController = AuthorizationViewController(viewModel: viewModel, hideAuthorizationNavigationResponder: hideUserAdditionalInfoNavigationResponder, showUserAdditionalInfoNavigationResponder: showUserAdditionalInfoNavigationResponder)
        return viewController
    }
    
    private func createUserAdditionalInfoViewController(hideUserAdditionalInfoNavigationResponder: HideUserAdditionalInfoNavigationResponder) -> UserAdditionalInfoViewController {
        let viewModel = UserAdditionalInfoViewModel()
        let viewController = UserAdditionalInfoViewController(viewModel: viewModel, hideUserAdditionalInfoNavigationResponder: hideUserAdditionalInfoNavigationResponder)
        return viewController
    }
    
    
    private func createAuthorizationViewModel() -> AuthorizationViewModel {
        let userStore = createUserStore()
        let authorizationManager = createFirebaseAuthorizationManager()
        let viewModel = AuthorizationViewModel(authorizationManager: authorizationManager, userStore: userStore)
        return viewModel
    }
    
    private func createUserStore() -> UserStore {
        let userStore = FirebaseUserStore()
        return userStore
    }
    
    private func createFirebaseAuthorizationManager() -> AuthorizationManager {
        let auth = Auth.auth()
        let googleAuthorizationClient = createGoogleAuthorizationClient()
        let authorizationManager = FirebaseAuthorizationManager(googleAuthorizationClient: googleAuthorizationClient , auth: auth)
        return authorizationManager
    }
    
    private func createGoogleAuthorizationClient() -> GoogleAuthorizationClient {
        let clientId = FirebaseApp.app()?.options.clientID ?? ""
        let presentationController = sharedWindow.rootViewController ?? UIViewController()
        let googleAuthorizationClient = MyBudgetGoogleAuthorizationClient(clientId: clientId, presentationController: presentationController)
        return googleAuthorizationClient
    }
    
    private func createTabBarController(mainViewModel: MainViewModel) -> UITabBarController {
        MyBudgetTabBarDependecyContainer(sharedMainViewModel: mainViewModel).makeTabBar()
    }
}
