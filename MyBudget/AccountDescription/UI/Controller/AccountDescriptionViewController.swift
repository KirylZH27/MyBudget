//
//  AccountDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit

final class AccountDescriptionViewController: NiblessViewController {
    
    var contentView: AccountDescriptionViewControllerView {
        view as! AccountDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = AccountDescriptionViewControllerView()
    }
    
}
