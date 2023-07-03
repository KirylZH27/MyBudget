//
//  EditProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 3.07.23.
//

import UIKit
final class EditProfileViewController: NiblessViewController {
    
    var contentView: EditProfileViewConttrollerView {
        view as! EditProfileViewConttrollerView
    }
    
    override func loadView() {
        super.loadView()
        view = EditProfileViewConttrollerView()
    }
}

