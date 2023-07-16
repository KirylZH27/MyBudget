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
        addDelegates()
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
    
    private func addDelegates(){
        contentView.accountPickerView.dataSource = self
        contentView.accountPickerView.delegate = self
    }
    
    private func addTargets() {
        contentView.addAccountButton.addTarget(self, action: #selector(addAccountButtonWasPressed), for: .touchUpInside)
    }
}

extension AddBankAccountViewController {
    @objc private func addAccountButtonWasPressed() {
        print("LLLLL")
        guard let name = contentView.nameAccountTextField.text else { return }
        guard let value = contentView.currentBalanceTextField.text else { return }
        let bankAccount = BankAccount(name: name, type: .cash, value: value)
        self.viewModel.createBankAccount(bankAccount: bankAccount)
    }
}

extension AddBankAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
}
