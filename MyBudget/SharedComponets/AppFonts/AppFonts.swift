//
//  AppFonts.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 15.07.23.
//

import UIKit

enum AppFonts {
    case AmericanBold
}

extension AppFonts {
    func value(size: CGFloat) -> UIFont? {
        switch self{
            case .AmericanBold:
                return UIFont(name: "AmericanTypewriter-Bold", size: size)
        }
    }
}
