//
//  UserDefaultAppColorDataSource.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 6.08.23.
//

import UIKit

final class UserDefaultAppColorDataSource: AppColorGetter, AppColorSetter {
   
    private let mainColorKey = "MyBudgetMainColorKey"
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func getMainColor() -> UIColor {
        guard let colorData = userDefault.data(forKey: mainColorKey) else { return #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1) }
        guard let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) else { return #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1) }
        return color
    }
    
    func saveMainColor(_ color: UIColor) {
        guard let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) else  { return }
        userDefault.set(colorData, forKey: mainColorKey)
    }
}
