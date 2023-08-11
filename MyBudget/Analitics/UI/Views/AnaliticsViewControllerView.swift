//
//  AnaliticsViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
import AAInfographics
final class AnaliticsViewControllerView: NiblessView {
    
    let totalChartView: AAChartView = {
        let view = AAChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.white.value
        
        layoutElemnts()
    }
    
    private func layoutElemnts(){
        layoutTotalChartView()
    }
    
    private func layoutTotalChartView(){
        addSubview(totalChartView)
        NSLayoutConstraint.activate([
            totalChartView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            totalChartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalChartView.heightAnchor.constraint(equalTo: totalChartView.widthAnchor, multiplier: 1)
        ])
    }
}
