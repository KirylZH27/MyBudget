//
//  AddTransactionCategoryViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 14.08.23.
//

import UIKit
import Combine

final class AddTransactionCategoryViewController: NiblessViewController {
    
    private let viewModel: AddTransactionCategoryViewModel
    private var cancellable = Set<AnyCancellable>()
    
    var contentView: AddTransactionCategoryViewControllerView {
        view as! AddTransactionCategoryViewControllerView
    }
    
    init(viewModel: AddTransactionCategoryViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AddTransactionCategoryViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Добавление категории"
        setupDelegates()
        addTargets()
        bindViewModel()
    }
    
    private func setupDelegates(){
        contentView.imagesCollectionView.delegate = self
        contentView.imagesCollectionView.dataSource = self
    }
    
    private func addTargets(){
        contentView.segmentedControll.addTarget(self, action: #selector(transactionTypeWasChanged(_:)), for: .valueChanged)
        contentView.saveTransactionCategoryButton.addTarget(self, action: #selector(saveTransactionCategoryButtonWasPressed) , for: .touchUpInside)
    }
    
    private func bindViewModel(){
        viewModel.transactionCategoryWasCreated.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }.store(in: &cancellable)
    }
}

extension AddTransactionCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AddTransactionCategoryImageCollectionViewCell.self), for: indexPath)
        guard let imageCell = cell as? AddTransactionCategoryImageCollectionViewCell else { return cell }
        imageCell.setupCell(imageName: viewModel.imageNames[indexPath.row])
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedImageName = viewModel.imageNames[indexPath.row]
    }
}

extension AddTransactionCategoryViewController {
    @objc func transactionTypeWasChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: viewModel.selectedTransactionType = .expenditure
            case 1: viewModel.selectedTransactionType = .income
            default: break
        }
    }
    
    @objc private func saveTransactionCategoryButtonWasPressed(){
        
        guard let name = contentView.nameTextField.text, !name.isEmpty else { return }
        guard let imageName = viewModel.selectedImageName else { return }
        guard let imageData = UIImage(named: imageName)?.jpegData(compressionQuality: 0.8) else { return }
        
        viewModel.createTransactionCategory(name: name, imageData: imageData)
     }
}

