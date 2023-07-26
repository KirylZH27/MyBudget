//
//  AnaliticsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class AnaliticsViewController: NiblessViewController {
    
    let viewModel: AnaliticsViewModel
    
    var contentView:
    AnaliticsViewControllerView {
        view as! AnaliticsViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = AnaliticsViewControllerView()
    }
    
    init(viewModel: AnaliticsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
