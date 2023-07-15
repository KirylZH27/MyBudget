//
//  AddTransactionViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit

final class AddTransactionViewController: NiblessViewController {
    
    private var previousOperand: String = ""
    private var currentOperand: String = ""
    private var OperationsType: String = ""
    private let empty: String = ""
    private let zero: String = KeyBoardSymbol.zero.rawValue
    private let decimalSeparator = Locale.current.decimalSeparator
    
    var contentView: AddTransactionViewControllerView {
        view as! AddTransactionViewControllerView
    }
    override func loadView() {
        super.loadView()
        view = AddTransactionViewControllerView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// ????
        //  AddTransactionViewControllerView.AddTransactionViewControllerKeyBoardView.delegate = self
    }
    
    private func setNumber(type: KeyBoardSymbol) {
        let number = type.rawValue
        
    }
}
extension AddTransactionViewController: KeyBoardDelegate {
        func onAction(type: KeyBoardSymbol) {
            switch type {
                case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
                    setNumber(type: type)
                default:
                    break
        }
    }
}
