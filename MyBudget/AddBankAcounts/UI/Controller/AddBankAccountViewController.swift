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
    
    var onDismissBlock: (() -> Void)?
    private let viewModel: AddBankAccountViewModel
    private var cancalable = Set<AnyCancellable>()
    private var bankAccountType: BankAccountType = .cash
    
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
        guard let name = contentView.nameAccountTextField.text else { return }
        guard let value = contentView.currentBalanceTextField.text else { return }
        
        let bankAccount = BankAccount(name: name, type: bankAccountType, value: value, id: UUID().uuidString)
        self.viewModel.createBankAccount(bankAccount: bankAccount)
    }
}

extension AddBankAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return BankAccountType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        BankAccountType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bankAccountType = BankAccountType.allCases[row]
    }
}
