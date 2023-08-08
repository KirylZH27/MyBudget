//
//  SettingsTableViewCell.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 4.07.23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let id = String(describing: SettingsTableViewCell.self)
    
    private let appColorGetter: AppColorGetter
    
    lazy var settingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign.square.fill")
        imageView.tintColor = appColorGetter.getMainColor()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    let settingTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Валюта по умолчанию"
        label.textColor = .black
        return label
    }()
    
    let settingSelectedElementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BYN"
        label.textColor = .black
        return label
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
    }
    
    private func layoutSettingImageView(){
        contentView.addSubview(settingImageView)
        NSLayoutConstraint.activate([
            settingImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            settingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            settingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            settingImageView.widthAnchor.constraint(equalToConstant: 50),
            settingImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func layoutSettingTypeLabel(){
        contentView.addSubview(settingTypeLabel)
        NSLayoutConstraint.activate([
            settingTypeLabel.leadingAnchor.constraint(equalTo: settingImageView.trailingAnchor, constant: 15),
            settingTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            settingTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    private func layoutSettingSelectedElementLabel(){
        contentView.addSubview(settingSelectedElementLabel)
        NSLayoutConstraint.activate([
            settingSelectedElementLabel.leadingAnchor.constraint(equalTo: settingTypeLabel.trailingAnchor, constant: 20),
            settingSelectedElementLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            settingSelectedElementLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            settingSelectedElementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
