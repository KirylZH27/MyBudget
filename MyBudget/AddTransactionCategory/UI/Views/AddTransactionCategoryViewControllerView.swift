//
//  AddTransactionCategoryViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import UIKit

final class AddTransactionCategoryViewControllerView: NiblessView {
    
    let nameTextField: UITextField = {
      let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.placeholder = "Название"
       textField.tintColor = AppColors.black.value
       textField.backgroundColor = AppColors.white.value
       textField.layer.cornerRadius = 8
       textField.layer.borderWidth = 1
       textField.textAlignment = .center
       textField.font = UIFont(name: "AmericanTypewriter-Bold", size: 22)
       return textField
   }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(AddTransactionCategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AddTransactionCategoryImageCollectionViewCell.self))
        return collectionView
    }()
    
    let segmentedControll: UISegmentedControl = {
        let segmentArray = [TransactionType.expenditure.rawValue, TransactionType.income.rawValue]
        let segmentedControll = UISegmentedControl(items: segmentArray)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        segmentedControll.selectedSegmentIndex = 0
        return segmentedControll
    }()
    
    lazy var saveTransactionCategoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.green.value
        button.setTitle("Добавить", for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFonts.AmericanBold.value(size: 22)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        layoutElements()
    }
    
    private func layoutElements(){
        layoutNameTextField()
        layoutImagesCollectionView()
        layoutSegmentedControll()
        layoutSaveButton()
    }
    
    private func layoutNameTextField(){
        addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func layoutImagesCollectionView(){
        addSubview(imagesCollectionView)
        NSLayoutConstraint.activate([
            imagesCollectionView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            imagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func layoutSegmentedControll(){
        addSubview(segmentedControll)
        NSLayoutConstraint.activate([
            segmentedControll.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: 10),
            segmentedControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func layoutSaveButton() {
        addSubview(saveTransactionCategoryButton)
        NSLayoutConstraint.activate([
            saveTransactionCategoryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveTransactionCategoryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            saveTransactionCategoryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveTransactionCategoryButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
