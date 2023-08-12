//
//  SettingsViewControllerTableViewHeaderView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 12.08.23.
//

import UIKit

class SettingsViewControllerTableViewHeaderView: NiblessView{
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = AppFonts.AmericanBold.value(size: 18)
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(text: String){
        self.titleLabel.text = text
    }
    
    private func layoutTitleLabel(){
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
