//
//  MyBudgetDependencyContainer.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
import FirebaseAuth
import Firebase

final class MyBudgetDependencyContainer {
    
    private let sharedWindow: UIWindow
    
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    func makeMainViewController () -> MainViewController {
        let viewModel = MainViewModel()
        
        let tabBarControllerFactory = {
            self.createTabBarController()
        }
        
        let authorizationViewControllerFactory = {
            self.createAuthorizationViewController(hideAuthorizationNavigationResponder: viewModel)
            
        }
        
        let viewController = MainViewController(viewModel: viewModel, tabBarControllerFactory: tabBarControllerFactory, authorizationViewControllerFactory: authorizationViewControllerFactory)
        return viewController
    }
    
    private func createAuthorizationViewController(hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder) -> AuthorizationViewController {
        let viewModel = createAuthorizationViewModel()
       
        let userAdditionalInfoViewControllerFactory = {
            self.createUserAdditionalInfoViewController(hideAuthorizationNavigationResponder: hideAuthorizationNavigationResponder)
        }
        let viewController = AuthorizationViewController(viewModel: viewModel, userAdditionalInfoViewControllerFactory: userAdditionalInfoViewControllerFactory)
        return viewController
    }
    
    private func createUserAdditionalInfoViewController(hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder) -> UserAdditionalInfoViewController {
        let viewModel = UserAdditionalInfoViewModel()
        let viewController = UserAdditionalInfoViewController(viewModel: viewModel, hideAuthorizationNavigationResponder: hideAuthorizationNavigationResponder)
        return viewController
    }
    
    
    private func createAuthorizationViewModel() -> AuthorizationViewModel {
        let authorizationManager = createFirebaseAuthorizationManager()
        let viewModel = AuthorizationViewModel(authorizationManager: authorizationManager)
        return viewModel
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
    
    private func createTabBarController() -> UITabBarController {
        MyBudgetTabBarDependecyContainer().makeTabBar()
    }
    
}
