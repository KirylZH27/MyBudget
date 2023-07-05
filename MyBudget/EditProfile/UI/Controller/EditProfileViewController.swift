//
//  EditProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 3.07.23.
//

import UIKit
final class EditProfileViewController: NiblessViewController {
    
    var contentView: EditProfileViewConttrollerView {
        view as! EditProfileViewConttrollerView
    }
    
    override func loadView() {
        super.loadView()
        view = EditProfileViewConttrollerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupActions()
    }
    
   // private func setUserInformation(profile: UserModel) {
 //   }
    
    private func addTargets() {
        contentView.saveNewProfileInfoButton.addTarget(self, action: #selector(saveNewProfileInfoButtonWasPressed), for: .touchUpInside)
    }
    private func setupActions() {
        contentView.ImageGesture.addTarget(self, action: #selector(imageWasPressed))
    }
}

extension EditProfileViewController {
    @objc private func saveNewProfileInfoButtonWasPressed() {
        print("Сохранил новое")
        
        if let navigationController = navigationController {
            // ???
            let viewController = ProfileViewController()
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc private func imageWasPressed() {
        print("Image was pressed")
    }
}
