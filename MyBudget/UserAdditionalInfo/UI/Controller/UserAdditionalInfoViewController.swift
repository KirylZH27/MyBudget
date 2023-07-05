//
//  UserAdditionalInfoViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 5.07.23.
//

import Foundation
final class UserAdditionalInfoViewController: NiblessViewController {
    
    private let viewModel: UserAdditionalInfoViewModel
    
    var contentView: UserAdditionalInfoViewControllerView {
        view as! UserAdditionalInfoViewControllerView
    }
    
    init(viewModel: UserAdditionalInfoViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = UserAdditionalInfoViewControllerView()
    }
    
    
}
