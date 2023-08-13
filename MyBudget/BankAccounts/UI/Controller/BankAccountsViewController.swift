//
//  BankAccountsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
import Combine

final class BankAccountsViewController: NiblessViewController {
    
    var contentView: BankAccountsViewControllerView {
        view as! BankAccountsViewControllerView
    }
    private let appColorGetter: AppColorGetter
    private let viewModel: BankAccountViewModel
    private var cancalable = Set<AnyCancellable>()
    private let addBankAccountViewControllerFactory: () -> AddBankAccountViewController
    private let accountDescriptionViewControllerFactory: (BankAccount) -> AccountDescriptionViewController
    
    
    init(viewModel: BankAccountViewModel,
         addBankAccountViewControllerFactory: @escaping ()-> AddBankAccountViewController, accountDescriptionViewControllerFactory: @escaping (BankAccount)-> AccountDescriptionViewController ) {
        self.viewModel = viewModel
        self.addBankAccountViewControllerFactory = addBankAccountViewControllerFactory
        self.accountDescriptionViewControllerFactory = accountDescriptionViewControllerFactory
        self.appColorGetter = UserDefaultAppColorDataSource()
        super.init()
    }
    override func loadView() {
        super.loadView()
        view = BankAccountsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = AppColors.black.value
        addTargets()
        addDelegates()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllAccounts()
        setupMainColor()
    }
    
    private func setupMainColor(){
        let mainColor = appColorGetter.getMainColor()
        contentView.addBankAccountButton.backgroundColor = mainColor
        changeColorInCells()
    }
    
    private func changeColorInCells(){
        let mainColor = appColorGetter.getMainColor()
        let visibleCells = contentView.tableView.visibleCells
        visibleCells.forEach { cell in
            let bankAccountCell = cell as? BankAccountsTableViewCell
            
            bankAccountCell?.personImageView.tintColor = mainColor
        }
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
    
    private func bindViewModel(){
        viewModel.allBankesWasGetted.sink { [weak self] _ in
            self?.contentView.tableView.reloadData()
        }.store(in: &cancalable)
        viewModel.isBankAccountWasDeleted.sink { [weak self] _ in
            self?.contentView.tableView.reloadData()
        }.store(in: &cancalable)
        viewModel.totalBalanceWasGetted.sink { [weak self] totalBalance in
            self?.contentView.totalBalanceView.balanceLabel.text = "\(totalBalance) Br"
        }.store(in: &cancalable)
    }
    
    private func addTargets() {
        contentView.addBankAccountButton.addTarget(self, action: #selector(addBankAccountButtonWasPressed) , for: .touchUpInside)
    }
}

extension BankAccountsViewController {
    @objc private func addBankAccountButtonWasPressed() {
        let addBankAccountViewController = addBankAccountViewControllerFactory()
        addBankAccountViewController.onDismissBlock = { [weak self] in
            self?.viewModel.getAllAccounts()
        }
        present(addBankAccountViewController, animated: true)
    }
}

extension BankAccountsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bankAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankAccountsTableViewCell.id, for: indexPath)
        guard let bankAccountCell = cell as? BankAccountsTableViewCell else
        { return cell }
        bankAccountCell.setupCell(bankAccount: viewModel.bankAccounts[indexPath.row])
        return bankAccountCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = viewModel.bankAccounts[indexPath.row]
        let accountDescriptionViewController = accountDescriptionViewControllerFactory(account)
        navigationController?.pushViewController(accountDescriptionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            showAlert(title: "Удаление",
                      message: "Хотите удалить счет?",
                      isCancelButton: true,
                      isOkDestructive: true,
                      okButtonName: "Удалить") { [weak self] in
                guard let self else { return }
                self.viewModel.deleteBankAccount(bankAccount: self.viewModel.bankAccounts[indexPath.row])
                self.viewModel.bankAccounts.remove(at: indexPath.row)
                self.contentView.tableView.deleteRows(at: [indexPath], with: .left)
                self.viewModel.recalculateTotalBalance()
            }
        }
    }
}

