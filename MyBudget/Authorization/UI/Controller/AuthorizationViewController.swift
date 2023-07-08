//
//  AuthorizationViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import UIKit
import Combine

final class AuthorizationViewController: NiblessViewController {
    
    var contentView:
    AuthorizationViewControllerView {
        view as! AuthorizationViewControllerView
    }
    
    private let viewModel: AuthorizationViewModel
    private let userAdditionalInfoViewControllerFactory: () -> UserAdditionalInfoViewController
    private var cancelable = Set<AnyCancellable>()
    private let hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder
    
    override func loadView() {
//        super.loadView() // FIXME: not needed
        view = AuthorizationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        bindViewModel()
        addTargets()
    }
    
    
    init(viewModel: AuthorizationViewModel, userAdditionalInfoViewControllerFactory: @escaping () -> UserAdditionalInfoViewController, hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder ) {
        self.viewModel = viewModel
        self.userAdditionalInfoViewControllerFactory = userAdditionalInfoViewControllerFactory
        self.hideAuthorizationNavigationResponder = hideAuthorizationNavigationResponder
        super.init()
    }
    
    private func bindViewModel(){
//        viewModel.isPresentUserAdditional.sink { [weak self] isPresentUserAdditional in
//            if isPresentUserAdditional {
//                self?.presentUserAdditionalInfo()
//            } else {
//                self?.hideAuthorizationNavigationResponder.hideAuthorization()
//            }
//        }.store(in: &cancelable)
    }
    
    private func presentUserAdditionalInfo(){
        let userAdditionalInfoViewController = userAdditionalInfoViewControllerFactory()
        
        navigationController?.setViewControllers([userAdditionalInfoViewController], animated: true)
    }
    
    private func addTargets() {
        contentView.continueWithGoogleButton.addTarget(self, action: #selector(continueWithGoogleButtonWasPressed) , for: .touchUpInside)
    }
}

extension AuthorizationViewController {
    @objc private func continueWithGoogleButtonWasPressed(){
        viewModel.requestGoogleAuthorization()
    }
}
