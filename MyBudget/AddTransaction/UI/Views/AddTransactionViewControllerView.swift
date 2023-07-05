//
//  AddTransactionViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
final class AddTransactionViewControllerView: NiblessView {
    
    let segmentedControll: UISegmentedControl = {
        let segmentArray = ["Расходы","Доходы"]
        let segmentedControll = UISegmentedControl(items: segmentArray)
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
 
        layoutElements()
    }
    
    private func layoutElements(){
        layoutSegmentedControll()
    }
    
    private func layoutSegmentedControll(){
        addSubview(segmentedControll)
        NSLayoutConstraint.activate([
            segmentedControll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
        ])
    }
}
