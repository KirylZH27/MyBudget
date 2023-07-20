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
        viewModel.getTransaction()
        addDelegates()
        
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func bindViewModel(){
        viewModel.allTransactionsWasGetted.sink{ [weak self] _ in
            self?.contentView.tableView.reloadData()
            self?.calculateTotalBalanse()
        }.store(in: &cancalable)
    }
    
    private func calculateTotalBalanse(){
        var incomeTransactions = viewModel.transactions.filter{ $0.type == .income }
        var expenditureTransactions = viewModel.transactions.filter { $0.type == .expenditure }
        
        let incomeValues = incomeTransactions.compactMap{ Double($0.value) }
        let expenditureValues = expenditureTransactions.compactMap{ Double($0.value) }
        
        let incomeSum = incomeValues.reduce(0,+) //  reduce - складываем все элемеенты массива
        let expenditureSum = expenditureValues.reduce(0,+)
        
        let totalBalance = incomeSum - expenditureSum
        
        contentView.balanceLabel.text = "\(totalBalance) Br"
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
}
