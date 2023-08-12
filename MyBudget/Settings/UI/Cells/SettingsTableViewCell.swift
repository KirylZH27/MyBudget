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
        imageView.image = UIImage(systemName: "dollarsign.square.fill")
        imageView.tintColor = appColorGetter.getMainColor()
        imageView.backgroundColor = AppColors.white.value
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let settingTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Валюта по умолчанию"
        label.textColor = AppColors.black.value
        return label
    }()
    
    let settingSelectedElementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BYN"
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
        layoutSettingSelectedElementLabel()
        layoutChangeThemeModeSwitch()
    }
    
    private func layoutSettingImageView(){
        contentView.addSubview(settingImageView)
        NSLayoutConstraint.activate([
            settingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            settingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            settingImageView.widthAnchor.constraint(equalToConstant: 50),
            settingImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func layoutSettingTypeLabel(){
        contentView.addSubview(settingTypeLabel)
        NSLayoutConstraint.activate([
            settingTypeLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 15),
            settingTypeLabel.centerYAnchor.constraint(equalTo: settingImageView.centerYAnchor)
        ])
    }
    
    private func layoutSettingSelectedElementLabel(){
        contentView.addSubview(settingSelectedElementLabel)
        NSLayoutConstraint.activate([
            settingSelectedElementLabel.leadingAnchor.constraint(equalTo: settingTypeLabel.trailingAnchor, constant: 20),
            settingSelectedElementLabel.centerYAnchor.constraint(equalTo: settingImageView.centerYAnchor),
            settingSelectedElementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func layoutChangeThemeModeSwitch(){
        contentView.addSubview(changeThemeModeSwitch)
        NSLayoutConstraint.activate([
            changeThemeModeSwitch.topAnchor.constraint(equalTo: settingImageView.bottomAnchor, constant: 10),
            changeThemeModeSwitch.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            changeThemeModeSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

extension SettingsTableViewCell {
    
    @objc private func switchWasPressed(sender: UISwitch){
        delegate?.switchDidChangeValue(state: sender.isOn)
    }
}
