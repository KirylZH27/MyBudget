//
//  AddTransactionViewControllerKeyBoardView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 12.07.23.
//

import UIKit

enum KeyBoardSymbol: String, CaseIterable {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case decimal
    
}
                    

final class AddTransactionViewControllerKeyBoardView: NiblessView {
    
    private var button: [UIButton] = []
    weak var delegate: KeyBoardDelegate?
    
    private let buttonInRow = 3
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            aligment: .fill,
            axis: .horizontal,
            distribution: .fillProportionally,
            userInteraction: true)
    
    private let mainStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            aligment: .fill,
            axis: .vertical,
            distribution: .fillEqually,
            userInteraction: true)
        .setLayoutMargins(top: 10, left: 12, right: 12, bottom: 10)
    /*
    private let lastStackView = UIStackView()
        .myStyleStack(
            spacing: 17,
            aligment: .fill,
            axis: .horizontal,
            distribution: .fillEqually,
            userInteraction: true)
    */
    private let zeroStackView = UIStackView()
        .myStyleStack(
            spacing: 0,
            aligment: .fill,
            axis: .horizontal,
            distribution: .fillEqually,
            userInteraction: true)
    
    private lazy var decimalSeparatorButton = KeyBoardButton(model: ModelKeyBoardButton(title: Locale.current.decimalSeparator ?? ".", backgroundColor: .systemPink, titleColor: .black), type: .decimal).setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private lazy var zeroButton = KeyBoardButton(model: ModelKeyBoardButton(title: KeyBoardSymbol.zero.rawValue, backgroundColor: .yellow, titleColor: .black), type: .decimal).setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private func createButton(type: KeyBoardSymbol) -> UIButton {
        let button: KeyBoardButton
        let title = type.rawValue
        
        switch type {
            default:
                button = KeyBoardButton(model: ModelKeyBoardButton(title: title, backgroundColor: AppColors.green.value, titleColor: .black), type: type)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        return button
    }
    
    private func createStackViewNumber(element: UIButton){
        if button.count < buttonInRow {
            button.append(element)
        } else {
            let stackView = UIStackView().myStyleStack(spacing: 17, aligment: .fill, axis: .horizontal, distribution: .fillEqually, userInteraction: true)
            button.forEach { button in
                stackView.addArrangedSubview(button)
            }
            mainStackView.addArrangedSubview(stackView)
            button.removeAll()
            button.append(element)
        }
    }
    
    private func createPositionButtons(){
        for numeral in KeyBoardSymbol.allCases {
            let numeralButton = createButton(type: numeral)
            createStackViewNumber(element: numeralButton)
        }
    }
    
    @objc func buttonAction(sender: KeyBoardButton){
        delegate?.onAction(type: sender.typeButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        createPositionButtons()
        setViewHierarhies()
        setUpConstraints()
    }
    
    
    private func setViewHierarhies(){
        self.addSubview(mainStackView)
        containerStackView.addArrangedSubview(zeroStackView)
        //containerStackView.addArrangedSubview(lastStackView)
        mainStackView.addArrangedSubview(containerStackView)
        zeroStackView.addArrangedSubview(zeroButton)
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            zeroButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.45)
        ])
    }
}
