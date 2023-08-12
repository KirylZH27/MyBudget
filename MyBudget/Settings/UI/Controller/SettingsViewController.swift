//
//  SettingsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class SettingsViewController: NiblessViewController {
    
    var elemets: [EnumSettings] = EnumSettings.allCases
    var appColorSetter: AppColorSetter
    private let appColorGetter: AppColorGetter
    
    var contentView: SettingsViewControllerView {
        view as! SettingsViewControllerView
    }
    
    init(appColorSetter: AppColorSetter = UserDefaultAppColorDataSource()) {
        self.appColorSetter = appColorSetter
        self.appColorGetter = UserDefaultAppColorDataSource()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = SettingsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDelegates()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMainColor()
    }
    
    private func setupMainColor(){
        changeColorInCells()
    }
    
    private func changeColorInCells(){
        let mainColor = appColorGetter.getMainColor()
        let visibleCells = contentView.tableView.visibleCells
        visibleCells.forEach { cell in
            let settingCell = cell as? SettingsTableViewCell
            
            settingCell?.settingImageView.tintColor = mainColor
        }
        let visibleCellsValue = contentView.tableView.visibleCells
        visibleCells.forEach{ cell in
            let settingCellValue = cell as? SettingsTableViewCellValue
            settingCellValue?.settingImageView.tintColor = mainColor
        }
    }
    
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.colorPickerController.delegate = self
    }
    
    private func addTargets(){
        contentView.changeColorButton.addTarget(self, action: #selector(changeColorButtonWasPressed) , for: .touchUpInside)
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        elemets.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
            {
                case 0:
                    return "Тема приложения"
                case 1:
                    return "Текущая валюта"
                default:
                    return ""
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath)
                guard let settingsCell = cell as? SettingsTableViewCell else
                { return cell }
                settingsCell.delegate = self
                return settingsCell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCellValue.id, for: indexPath)
                guard let settingsThemeCell = cell as? SettingsTableViewCellValue else { return cell }
                return settingsThemeCell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCellValue.id, for: indexPath)
                guard let settingsThemeCell = cell as? SettingsTableViewCellValue else { return cell }
                return settingsThemeCell
        }
    }
}

extension SettingsViewController {
    @objc private func changeColorButtonWasPressed(){
        present(contentView.colorPickerController, animated: true)
     }
}

extension SettingsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        
        appColorSetter.saveMainColor(color)
    }
}

extension SettingsViewController: SettingsTableViewCellDelegate {
    func switchDidChangeValue(state isOn: Bool) {
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = isOn ? .dark : .light
        
    }
}
