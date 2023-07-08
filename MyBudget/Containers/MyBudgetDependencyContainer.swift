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
    
    // MARK: - Private properties
    private let sharedWindow: UIWindow
    private let navigationController = UINavigationController()
    
    
    
    // MARK: - Inits
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    
    // MARK: - Public methods
    func start() {
        navigationController.isNavigationBarHidden = true
        
        setupWindow()
        addLogoutObserver()
    }
    
    
    // MARK: - Private properties
    private func makeMainViewController() -> MainViewController {
        let viewModel = MainViewModel()
        
        let tabBarControllerFactory = {
            self.createTabBarController()
        }
        
        let authorizationViewControllerFactory = {
            self.createAuthorizationViewController(hideAuthorizationNavigationResponder: viewModel)
        }
        
        let viewController = MainViewController(viewModel: viewModel,
                                                tabBarControllerFactory: tabBarControllerFactory)
        
        return viewController
    }
    
    private func createAuthorizationViewController(hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder) -> AuthorizationViewController {
        let viewModel = createAuthorizationViewModel()
        
        let userAdditionalInfoViewControllerFactory = {
            self.createUserAdditionalInfoViewController(hideAuthorizationNavigationResponder: hideAuthorizationNavigationResponder)
        }
        let viewController = AuthorizationViewController(viewModel: viewModel, userAdditionalInfoViewControllerFactory: userAdditionalInfoViewControllerFactory, hideAuthorizationNavigationResponder: hideAuthorizationNavigationResponder)
        return viewController
    }
    
    private func createUserAdditionalInfoViewController(hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder) -> UserAdditionalInfoViewController {
        let viewModel = UserAdditionalInfoViewModel()
        let viewController = UserAdditionalInfoViewController(viewModel: viewModel)
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
    
    private func createTabBarController() -> UITabBarController {
        MyBudgetTabBarDependecyContainer().makeTabBar()
    }
    
    private func addLogoutObserver() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                let userStore = self.createUserStore()
                
                userStore.checkIfUserExist(by: user.uid) { isUserExist in
                    if isUserExist {
                        let vc = self.makeMainViewController()
                        
                        self.navigationController.setViewControllers([vc], animated: true)
                    } else {
                        let viewModel = UserAdditionalInfoViewModel()
                        let vc = UserAdditionalInfoViewController(viewModel: viewModel)
                        
                        self.navigationController.setViewControllers([vc], animated: true)
                    }
                }
            } else {
                let viewModel = MainViewModel()
                let vc = self.createAuthorizationViewController(hideAuthorizationNavigationResponder: viewModel)
                
                self.navigationController.setViewControllers([vc], animated: true)
            }
        }
    }
    
    private func setupWindow() {
        sharedWindow.rootViewController = navigationController
        sharedWindow.makeKeyAndVisible()
    }
    
}
