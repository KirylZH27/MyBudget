//
//  UserAdditionalInfoViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
final class UserAdditionalInfoViewController: NiblessViewController {
    
    private let viewModel: UserAdditionalInfoViewModel
    private let hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder
    
    var contentView: UserAdditionalInfoViewControllerView {
        view as! UserAdditionalInfoViewControllerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideAuthorizationNavigationResponder.hideAuthorization()
    }
    
    init(viewModel: UserAdditionalInfoViewModel, hideAuthorizationNavigationResponder: HideAuthorizationNavigationResponder) {
        self.viewModel = viewModel
        self.hideAuthorizationNavigationResponder = hideAuthorizationNavigationResponder
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = UserAdditionalInfoViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    private func addTargets() {
        contentView.saveProfileInfoButton.addTarget(self, action: #selector(SaveProfileInfoButtonWasPressed), for: .touchUpInside)
    }
    
}

extension UserAdditionalInfoViewController {
    @objc private func SaveProfileInfoButtonWasPressed() {
        print("SaveProfileInfoButton was pressed")
    }
}

