//
//  SettingsViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 27.06.23.
//

import UIKit
final class SettingsViewController: NiblessViewController {
    
    var contentView: SettingsViewControllerView {
        view as! SettingsViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        view = SettingsViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDelegates()
    }
    private func addDelegates(){
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
