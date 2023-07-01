//
//  AuthorizationViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 1.07.23.
//

import UIKit
final class AuthorizationViewController: NiblessViewController {
    
    var contentView:
    AuthorizationViewControllerView {
        view as! AuthorizationViewControllerView
    }
    
    private let viewModel: AuthorizationViewModel
    
    override func loadView() {
        super.loadView()
        view = AuthorizationViewControllerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.requestGoogleAuthorization()
    }
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
