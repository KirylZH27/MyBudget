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
    init(viewModel: AuthorizationViewModel, userAdditionalInfoViewControllerFactory: @escaping () -> UserAdditionalInfoViewController ) {
        self.viewModel = viewModel
        self.userAdditionalInfoViewControllerFactory = userAdditionalInfoViewControllerFactory
        super.init()
    }
    
    private func bindViewModel(){
        viewModel.isPresentUserAdditional.sink { [weak self] _ in
            self?.presentUserAdditionalInfo()
        }.store(in: &cancelable)
    }
    
    private func presentUserAdditionalInfo(){
        let userAdditionalInfoViewController = userAdditionalInfoViewControllerFactory()
        navigationController?.pushViewController(userAdditionalInfoViewController, animated: true)
    }
}
