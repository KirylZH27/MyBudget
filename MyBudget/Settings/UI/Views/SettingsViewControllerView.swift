//
//  SettingsViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class SettingsViewControllerView: NiblessView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElemets()
        backgroundColor = .white
    }
    
    private func layoutElemets(){
        layoutSettingsTableView()
    }
    private func layoutSettingsTableView(){
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
