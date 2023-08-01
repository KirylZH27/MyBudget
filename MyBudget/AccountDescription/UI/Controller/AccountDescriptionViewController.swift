//
//  AccountDescriptionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 16.07.23.
//

import UIKit
import Combine

final class AccountDescriptionViewController: NiblessViewController {
    
    private let viewModel: AccountDescriptionViewModel
    private var cancalable = Set<AnyCancellable>()
    
    
    var contentView: AccountDescriptionViewControllerView {
        view as! AccountDescriptionViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = AccountDescriptionViewControllerView()
    }
    
    init(viewModel: AccountDescriptionViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        addDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTransaction()
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func bindViewModel(){
        viewModel.allTransactionsWasGetted.sink{ [weak self] _ in
            self?.contentView.tableView.reloadData()
            self?.viewModel.calculateTotalBalanse()
        }.store(in: &cancalable)
        viewModel.totalBalanseWasCalculated.sink { [weak self] totalBalance in
            self?.contentView.balanceLabel.text = "\(totalBalance) Br"
        }.store(in: &cancalable)
        viewModel.isTransactionWasDeleted.sink { [weak self] _ in
            self?.viewModel.calculateTotalBalanse()
        }.store(in: &cancalable)
    }
    
}

extension AccountDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountDescriptionTableViewCell.id, for: indexPath)
        guard let accountDescriptionCell = cell as? AccountDescriptionTableViewCell else
        { return cell }
        accountDescriptionCell.setupCell(accountDescription: viewModel.transactions[indexPath.row])
        return accountDescriptionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            showAlert(title: "Удаление",
                      message: "Хотите удалить данную транзакцию?",
                      isCancelButton: true,
                      isOkDestructive: true,
                      okButtonName: "Удалить") { [weak self] in
                guard let self else { return }
                self.viewModel.deleteTransaction(transaction: self.viewModel.transactions.remove(at: indexPath.row))
                self.contentView.tableView.deleteRows(at: [indexPath], with: .left)
            }
        }
    }
}
