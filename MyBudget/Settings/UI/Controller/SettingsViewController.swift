//
//  SettingsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class SettingsViewController: NiblessViewController {
    
    var contentView: SettingsViewControllerView {
        view as! SettingsViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = SettingsViewControllerView()
    }
}
