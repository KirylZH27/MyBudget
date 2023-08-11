//
//  AppColors.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 4.07.23.
//

import UIKit

public enum AppColors {
    case white
    case black
    case green
    case gray
}

extension AppColors {
    var value: UIColor {
        switch self {
        case .white:
                return UIColor(named: "White") ?? #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        case .black:
                return UIColor(named: "Black") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .green: return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .gray: return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
