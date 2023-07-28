//
//  TransactionWasAddedAnimationViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 28.07.23.
//

import UIKit

final class TransactionWasAddedAnimationViewController: NiblessViewController {
    
    var contentView: TransactionWasAddedAnimationViewControllerView {
        view as! TransactionWasAddedAnimationViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = TransactionWasAddedAnimationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.startAnimation {
            self.parent?.remove(childViewController: self)
        }
    }
    
}
