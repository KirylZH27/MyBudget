//
//  AnaliticsViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
import DGCharts

final class AnaliticsViewControllerView: NiblessView {
    
    let groupBarChart: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let data = BarChartData()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        layoutElemnts()
    }
    
    private func layoutElemnts(){
        layoutGroupBarChart()
    }
    
    private func layoutGroupBarChart(){
        addSubview(groupBarChart)
        NSLayoutConstraint.activate([
            groupBarChart.topAnchor.constraint(equalTo: topAnchor),
            groupBarChart.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupBarChart.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupBarChart.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
