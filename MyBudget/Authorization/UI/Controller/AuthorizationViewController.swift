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
        super.loadView()
        view = AuthorizationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.requestGoogleAuthorization()
    }
    init(viewModel: AuthorizationViewModel, userAdditionalInfoViewControllerFactory: @escaping () -> UserAdditionalInfoViewController, hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder ) {
        self.viewModel = viewModel
        self.userAdditionalInfoViewControllerFactory = userAdditionalInfoViewControllerFactory
        self.hideAuthorizationNavigationResponder = hideAuthorizationNavigationResponder
        super.init()
    }
    
    private func bindViewModel(){
        viewModel.isPresentUserAdditional.sink { [weak self] isPresentUserAdditional in
            if isPresentUserAdditional {
                self?.presentUserAdditionalInfo()
            }else {
                self?.hideAuthorizationNavigationResponder.hideAuthorization()
            }
        }.store(in: &cancelable)
    }
    
    private func presentUserAdditionalInfo(){
        let userAdditionalInfoViewController = userAdditionalInfoViewControllerFactory()
        navigationController?.pushViewController(userAdditionalInfoViewController, animated: true)
    }
}
