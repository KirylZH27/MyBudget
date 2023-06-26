//
//  AddTransactionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class AddTransactionViewController: NiblessViewController {
    var contentView: AddTransactionViewControllerView {
        view as! AddTransactionViewControllerView
    }
    override func loadView() {
        super.loadView()
        view = AddTransactionViewControllerView()
    }
}
