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
    private var cancelable = Set<AnyCancellable>()
    private let hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder
    private let showUserAdditionalInfoNavigationResponder: ShowUserAditionalInfoNavigationResponder
    
    override func loadView() {
        super.loadView()
        view = AuthorizationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        bindViewModel()
        addTargets()
    }
    
    init(viewModel: AuthorizationViewModel, hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder, showUserAdditionalInfoNavigationResponder: ShowUserAditionalInfoNavigationResponder) {
        self.viewModel = viewModel
        self.hideAuthorizationNavigationResponder = hideAuthorizationNavigationResponder
        self.showUserAdditionalInfoNavigationResponder = showUserAdditionalInfoNavigationResponder
        super.init()
    }
    
    private func bindViewModel(){
        viewModel.isPresentUserAdditional.sink { [weak self] isPresentUserAdditional in
            if isPresentUserAdditional {
                self?.showUserAdditionalInfoNavigationResponder.showUserAdditionalInfo()
            } else {
                self?.hideAuthorizationNavigationResponder.hideAuthorization()
            }
        }.store(in: &cancelable)
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
