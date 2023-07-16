//
//  AccountDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit

final class AccountDescriptionViewController: NiblessViewController {
    
    private let viewModel: AccountDescriptionViewModel
    
    var contentView: AccountDescriptionViewControllerView {
        view as! AccountDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = AccountDescriptionViewControllerView()
    }
    
    init(viewModel: AccountDescriptionViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTransaction()
    }
}
