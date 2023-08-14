//
//  SettingsViewModel.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.08.23.
//

import UIKit
import Combine

final class SettingsViewModel {
    
    let elemets: [EnumSettings]
    private (set) var mainColor = PassthroughSubject<UIColor,Never>()
    private (set) var darkModeState = PassthroughSubject<Bool,Never>()
    private let appColorSetter: AppColorSetter
    private let appColorGetter: AppColorGetter
    
    private let darkModeSetter: DarkModeSetter
    private let darkModeGetter: DarkModeGetter
    
    init(appColorSetter: AppColorSetter, appColorGetter: AppColorGetter, darkModeSetter: DarkModeSetter, darkModeGetter: DarkModeGetter) {
        self.elemets = EnumSettings.allCases
        self.appColorSetter = appColorSetter
        self.appColorGetter = appColorGetter
        self.darkModeSetter = darkModeSetter
        self.darkModeGetter = darkModeGetter
    }
    
    func getMainColor(){
        let mainColor = appColorGetter.getMainColor()
        self.mainColor.send(mainColor)
    }

    func saveMainColor(mainColor: UIColor){
        appColorSetter.saveMainColor(mainColor)
    }
    
    func getDarkModeState(){
        let state = darkModeGetter.getDarkModeState()
        self.darkModeState.send(state)
    }
    
    func saveDarkModeState(isOn: Bool){
        darkModeSetter.saveDarkModeState(state: isOn)
    }
    
    func changeDarkMode(){
        let state = darkModeGetter.getDarkModeState()
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = state ? .dark : .light
    }
}
