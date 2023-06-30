//
//  ProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 30.06.23.
//

import UIKit
final class ProfileViewController: NiblessViewController {
    
    var contentView: ProfileViewControllerView {
        view as! ProfileViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = ProfileViewControllerView()
    }
}
