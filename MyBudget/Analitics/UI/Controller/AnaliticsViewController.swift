//
//  AnaliticsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
import Combine

final class AnaliticsViewController: NiblessViewController {
    
    let viewModel: AnaliticsViewModel
    private var cancelable = Set<AnyCancellable>()
    
    var contentView:
    AnaliticsViewControllerView {
        view as! AnaliticsViewControllerView
    }

    init(viewModel: AnaliticsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AnaliticsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getTotalChartModel()
    }
    
    private func bindViewModel(){
        viewModel.totalChartModelCalculated.sink {[weak self] chartModel in
            self?.contentView.totalChartView.aa_drawChartWithChartModel(chartModel)
        }.store(in: &cancelable)
    }
}
