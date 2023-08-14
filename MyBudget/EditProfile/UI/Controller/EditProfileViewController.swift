//
//  EditProfileViewController.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 3.07.23.
//

import UIKit
import FirebaseAuth
import AVFoundation

final class EditProfileViewController: NiblessViewController {
    
    var contentView: EditProfileViewConttrollerView {
        view as! EditProfileViewConttrollerView
    }
    
    var userModel: UserModel!
    var completion: ((UserModel) -> Void)?
    
    override func loadView() {
        view = EditProfileViewConttrollerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupActions()
    }
    
    private lazy var imagePicker: ImagePicker = {
        return ImagePicker(presentationController: self, delegate: self)
    }()
    
    private func selectImageFromLibrary() {
        imagePicker.present(from: contentView.imageView)
    }
    
    private func addTargets() {
        contentView.saveNewProfileInfoButton.addTarget(self, action: #selector(saveNewProfileInfoButtonWasPressed), for: .touchUpInside)
    }
    
    private func setupActions() {
        contentView.imageView.addTapGesture { _ in
            self.selectImageFromLibrary()
        }
    }
}

extension EditProfileViewController {
    
    @objc private func saveNewProfileInfoButtonWasPressed() {
        guard
            let userModel
        else { return }
        
        guard
            let userName = contentView.nameTextField.text,
            !userName.isEmpty
//                ,
//            let userEmail = contentView.emailTextField.text,
//            !userEmail.isEmpty
        else {
            showAlert(title: "Ошибка",
                      message: "Укажите имя пользователя и почту")
            return
        }
        
        
        let userStore = FirebaseUserStore()
        let newUserModel = UserModel(email: userModel.email,
                                  name: userName,
                                  imageURLString: userModel.imageURLString,
                                  id: userModel.id)
        
        userStore.save(user: newUserModel) { [weak self] result in
            switch result {
                case .failure(_):
                ()
            case .success(_):
                print("Сохранил новое")
                self?.completion?(newUserModel)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func saveUserAvatar(selectedImage: UIImage?) {
        guard
            let uid = Auth.auth().currentUser?.uid,
            let selectedImage = selectedImage else {
            showAlert(type: .alert(title: "Ошибка загрузки!",
                                   message: "Попробуйте выбрать фото еще раз"))
            return
        }
        
        let userPhoto = selectedImage.scale(newSize: CGSize(width: 300, height: 300))
        
        guard let imageData = userPhoto?.resizeByByte(maxByte: 400000) else {
            
            showAlert(type: .alert(title: "Ошибка загрузки!",
                                   message: "Попробуйте выбрать фото еще раз"))
            return
        }
        
        let userStore = FirebaseUserStore()
        
        userStore.uploadImage(imageData: imageData,
                              uid: uid) { result in

            switch result {
                case .failure(_):
                ()
            case .success(let url):
                print("Сохранил новое")
                self.contentView.imageView.image = selectedImage
                
                guard let userModel = self.userModel else { return }
                
                userModel.imageURLString = url
                
                self.completion?(userModel)
            }
        }
    }
    
    // MARK: Checking Camera Permissions
    // MARK: Before opening the camera, each time it checks if there is access to it, and if not, it shows a message with the need to grant access
    
   private func checkCameraPermissions() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)

        switch authStatus {
        case .authorized:
            selectImageFromLibrary()
        case .denied:
            openAppSettings()
        default:
            selectImageFromLibrary()
        }
        
        func openAppSettings() {
            showAlert(type: .alert(title: "Ошибка!",
                                   message: "Нужен доступ к камере для фото профиля, Вы можете изменить его в настройках приложения"),
                      isCancelButton: true,
                      isOkDestructive: true,
                      okButtonName: "Настройки") {
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            }
        }
    }
}

extension EditProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        saveUserAvatar(selectedImage: image)
    }
    
    func didCancelled() {
    }
}
