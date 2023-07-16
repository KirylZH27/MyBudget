//
//  AddBankAccountViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import UIKit
import Combine

final class AddBankAccountViewController: NiblessViewController {
    
    var contentView: AddBankAccountViewControllerView {
        view as! AddBankAccountViewControllerView
    }
    
    private let viewModel: AddBankAccountViewModel
    private var cancalable = Set<AnyCancellable>()
    var onDismissBlock: (() -> Void)?
    
    init(viewModel: AddBankAccountViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AddBankAccountViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        addTargets()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
         //   let bankAccount = BankAccount(name: "Testname55", type: .cash, value: "500")
          //  self.viewModel.createBankAccount(bankAccount: bankAccount)
        }
    }
    
    
    private func bindViewModel() {
        viewModel.isBankAccountCreated.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.dismiss(animated: true) { [weak self] in
                    self?.onDismissBlock?()
                }
            }
        }.store(in: &cancalable)
    }
    
    private func addTargets() {
        contentView.addAccountButton.addTarget(self, action: #selector(addAccountButtonWasPressed), for: .touchUpInside)
    }
}

extension AddBankAccountViewController {
    @objc private func addAccountButtonWasPressed() {
        print("LLLLL")
        let bankAccount = BankAccount(name: "Cash", type: .cash, value: "500")
        self.viewModel.createBankAccount(bankAccount: bankAccount)
    }
}
