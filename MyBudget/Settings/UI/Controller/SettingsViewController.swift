//
//  SettingsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
import Combine

final class SettingsViewController: NiblessViewController {
    
    let viewModel: SettingsViewModel
    private var cancalable = Set<AnyCancellable>()
    
    var contentView: SettingsViewControllerView {
        view as! SettingsViewControllerView
    }
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
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
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMainColor()
        viewModel.getDarkModeState()
    }
    
    private func bindViewModel(){
        
        viewModel.darkModeState.receive(on: DispatchQueue.main).sink { [weak self] state in
            let switchIndexPath = IndexPath(row: 0, section: 0)
            let switchCell = self?.contentView.tableView.cellForRow(at: switchIndexPath) as? SettingsTableViewCell
            switchCell?.changeThemeModeSwitch.isOn = state
        }.store(in: &cancalable)
        
        viewModel.mainColor.receive(on: DispatchQueue.main).sink { [weak self] mainColor in
            self?.changeColorInCells(mainColor: mainColor)
        }.store(in: &cancalable)
    }
    
    private func changeColorInCells(mainColor: UIColor){
        let visibleCells = contentView.tableView.visibleCells
        visibleCells.forEach { cell in
            let settingCell = cell as? SettingsTableViewCell
            
            settingCell?.settingImageView.tintColor = mainColor
        }
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
        viewModel.elemets.count
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
        
        viewModel.saveMainColor(mainColor: color)
        viewModel.getMainColor()
    }
}

extension SettingsViewController: SettingsTableViewCellDelegate {
    func switchDidChangeValue(state isOn: Bool) {
        viewModel.saveDarkModeState(isOn: isOn)
        viewModel.changeDarkMode()
        
    }
}
