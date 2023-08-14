//
//  UserDefaultSwitchStateDataSource.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.08.23.
//

import UIKit

final class UserDefaultDarkModeStateDataSource: DarkModeGetter, DarkModeSetter {
    
    private let darkModeeKey = "MyBudgetSwitchStateKey"
    private let userDefault: UserDefaults
    
    init(userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func getDarkModeState() -> Bool {
        userDefault.bool(forKey: darkModeeKey)
    }
    
    func saveDarkModeState(state isOn: Bool) {
        userDefault.set(isOn, forKey: darkModeeKey)
    }
}
