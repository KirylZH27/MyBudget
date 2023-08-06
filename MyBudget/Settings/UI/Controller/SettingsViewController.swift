//
//  SettingsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class SettingsViewController: NiblessViewController {
    
    var appColorSetter: AppColorSetter
    
    var contentView: SettingsViewControllerView {
        view as! SettingsViewControllerView
    }
    
    init(appColorSetter: AppColorSetter = UserDefaultAppColorDataSource()) {
        self.appColorSetter = appColorSetter
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
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath)
        guard let settingsCell = cell as? SettingsTableViewCell else
        { return cell }
        return settingsCell
    }
    
  //  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //      return 60
  //  }
}

extension SettingsViewController {
    @objc private func changeColorButtonWasPressed(){
        present(contentView.colorPickerController, animated: true)
     }
}

extension SettingsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        
        appColorSetter.saveMainColor(color)
        
        //MARK: - Сделать аллерт
    }
}
