//
//  SettingsTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 4.07.23.
//

import UIKit

protocol SettingsTableViewCellDelegate: AnyObject{
    func switchDidChangeValue(state isOn: Bool)
}

class SettingsTableViewCell: UITableViewCell {
    
    static let id = String(describing: SettingsTableViewCell.self)
    
    weak var delegate: SettingsTableViewCellDelegate?
    
    private let appColorGetter: AppColorGetter
    
    lazy var settingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "moonphase.first.quarter")
        imageView.tintColor = appColorGetter.getMainColor()
        imageView.backgroundColor = AppColors.white.value
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let settingTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Светлая/Темная тема"
        label.textColor = AppColors.black.value
        return label
    }()
    
    lazy var changeThemeModeSwitch: UISwitch = {
        let switchUI = UISwitch()
        switchUI.translatesAutoresizingMaskIntoConstraints = false
        switchUI.addTarget(self, action: #selector(switchWasPressed(sender:)), for: .valueChanged)
        return switchUI
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements(){
        layoutSettingImageView()
        layoutSettingTypeLabel()
        layoutChangeThemeModeSwitch()
    }
    
    private func layoutSettingImageView(){
        contentView.addSubview(settingImageView)
        NSLayoutConstraint.activate([
            settingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            settingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            settingImageView.widthAnchor.constraint(equalToConstant: 50),
            settingImageView.heightAnchor.constraint(equalToConstant: 50),
            settingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func layoutSettingTypeLabel(){
        contentView.addSubview(settingTypeLabel)
        NSLayoutConstraint.activate([
            settingTypeLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 15),
            settingTypeLabel.centerYAnchor.constraint(equalTo: settingImageView.centerYAnchor)
        ])
    }
    
    private func layoutChangeThemeModeSwitch(){
        contentView.addSubview(changeThemeModeSwitch)
        NSLayoutConstraint.activate([
            
            changeThemeModeSwitch.centerYAnchor.constraint(equalTo: settingImageView.centerYAnchor),
            changeThemeModeSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

extension SettingsTableViewCell {
    
    @objc private func switchWasPressed(sender: UISwitch){
        delegate?.switchDidChangeValue(state: sender.isOn)
    }
}
