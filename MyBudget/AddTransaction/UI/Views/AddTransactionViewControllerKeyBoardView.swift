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
    case backspace
    
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
        .setLayoutMargins(top: 30, left: 30, right: 30, bottom: 30)
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
            spacing: 17,
            aligment: .fill,
            axis: .horizontal,
            distribution: .fillEqually,
            userInteraction: true)
    
    let saveTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Добавить", for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var decimalSeparatorButton: KeyBoardButton = {
        let model = ModelKeyBoardButton(title: Locale.current.decimalSeparator ?? ".",
                                        backgroundColor: .systemPink,
                                        titleColor: .black,
                                        font: AppFonts.AmericanBold.value(size: 28))
        let button = KeyBoardButton(model: model, type: .decimal)
            .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
        return button
    }()
    
    private lazy var backspaceButton: KeyBoardButton = {
        let model = ModelKeyBoardButton(title: "",
                                        backgroundColor: .systemPink,
                                        titleColor: .black,
                                        font: AppFonts.AmericanBold.value(size: 28))
        let button = KeyBoardButton(model: model, type: .backspace)
            .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
        button.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        return button
    }()
    
    private lazy var zeroButton: KeyBoardButton = {
        let model = ModelKeyBoardButton(title: KeyBoardSymbol.zero.rawValue,
                                        backgroundColor: .yellow,
                                        titleColor: .black,
                                        font: AppFonts.AmericanBold.value(size: 28))
        let button = KeyBoardButton(model: model, type: .zero)
            .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
        return button
    }()
    
    
    
    private func createButton(type: KeyBoardSymbol) -> UIButton {
        let button: KeyBoardButton
        let title = type.rawValue
        
        switch type {
            default:
                let model = ModelKeyBoardButton(title: title,
                                                backgroundColor: AppColors.green.value,
                                                titleColor: .black,
                                                font: AppFonts.AmericanBold.value(size: 28))
                button = KeyBoardButton(model: model, type: type)
                    .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
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
        layoutSaveButton()
        setUpConstraints()
    }
    
    
    private func setViewHierarhies(){
        self.addSubview(mainStackView)
        containerStackView.addArrangedSubview(zeroStackView)
        //containerStackView.addArrangedSubview(lastStackView)
        mainStackView.addArrangedSubview(containerStackView)
        zeroStackView.addArrangedSubview(zeroButton)
        zeroStackView.addArrangedSubview(decimalSeparatorButton)
        zeroStackView.addArrangedSubview(backspaceButton)
    }
    
    
    private func layoutSaveButton() {
        addSubview(saveTransactionButton)
        NSLayoutConstraint.activate([
            saveTransactionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            saveTransactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveTransactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveTransactionButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: saveTransactionButton.topAnchor, constant: -10)
        ])
    }
    
    
    
}
