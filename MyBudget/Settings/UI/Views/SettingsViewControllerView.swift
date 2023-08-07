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
    
    let changeColorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Выбрать цвет", for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFonts.AmericanBold.value(size: 22)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colorPickerController = UIColorPickerViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElemets()
        backgroundColor = .white
    }
    
    private func layoutElemets(){
        layoutSettingsTableView()
        layoutChangeColorButton()
    }
    private func layoutSettingsTableView(){
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func layoutChangeColorButton(){
        addSubview(changeColorButton)
        NSLayoutConstraint.activate([
            changeColorButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            changeColorButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            changeColorButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            changeColorButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
