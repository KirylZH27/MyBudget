//
//  AddTransactionCategoryViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import Foundation
final class AddTransactionCategoryViewController: NiblessViewController {
    
    private let viewModel: AddTransactionCategoryViewModel
    
    var contentView: AddTransactionCategoryViewControllerView {
        view as! AddTransactionCategoryViewControllerView
    }
    
    init(viewModel: AddTransactionCategoryViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AddTransactionCategoryViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
