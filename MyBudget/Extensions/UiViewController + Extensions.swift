//
//  UiViewController + Extensions.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 25.06.23.
//

import UIKit
extension UIViewController {
    
    func addFullScreen(childViewController child: UIViewController, topConstant: CGFloat = 0) {
        guard child.parent == nil else {
            return
        }
        
        addChild(child)
        view.addSubview(child.view)
        
        view.backgroundColor = .white
        view.tintColor = .white
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: child.view.topAnchor, constant: -topConstant),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        view.addConstraints(constraints)
        
        child.didMove(toParent: self)
    }
    
    func remove(childViewController child: UIViewController?) {
        
        guard let child = child, child.parent != nil else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

extension UIViewController {
    
    func showAlert(title: String,
                   message: String,
                   isCancelButton: Bool? = nil,
                   isOkDestructive: Bool? = nil,
                   okButtonName: String? = nil,
                   customButtons: [UIAlertAction] = [UIAlertAction](),
                   preferredStyle: UIAlertController.Style = .alert,
                   sourceView: UIView? = nil,
                   completion: (() -> Void)? = nil) {
        
        showAlert(type: .alert(title: title,
                               message: message),
                  isCancelButton: isCancelButton,
                  isOkDestructive: isOkDestructive,
                  okButtonName: okButtonName,
                  customButtons: customButtons,
                  preferredStyle: preferredStyle,
                  sourceView: sourceView,
                  completion: completion)
    }
    
    func showAlert(type: AlertType,
                   isCancelButton: Bool? = nil,
                   isOkDestructive: Bool? = nil,
                   okButtonName: String? = nil,
                   customButtons: [UIAlertAction] = [UIAlertAction](),
                   preferredStyle: UIAlertController.Style = .alert,
                   sourceView: UIView? = nil,
                   completion: (() -> Void)? = nil) {
        
        let okDefaultName = "Ок"
        let cancelDefaultName = "Отмена"
        
        func addActionSheetForiPad(actionSheet: UIAlertController) {
            if let popoverPresentationController = actionSheet.popoverPresentationController, let sourceView = sourceView {
                popoverPresentationController.sourceView = sourceView
                popoverPresentationController.sourceRect = sourceView.bounds
                popoverPresentationController.permittedArrowDirections = [.down, .up]
            }
        }
        
        
        var alert = UIAlertController()
        
        switch type {
        case .alert(let title, let message):
            alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        case .localizedError(let error):
            let title = error.errorDescription
            let message = [
                error.failureReason,
                error.recoverySuggestion
            ].compactMap { $0 }
                .joined(separator: "\n\n")
            
            alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        case .NSError(let error):
            let title = "Ошибка!"
            let message = [
                error.localizedDescription,
                error.localizedFailureReason,
                error.localizedRecoverySuggestion
            ].compactMap { $0 }
                .joined(separator: "\n\n")
            
            alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        }
        
        var allButtons = [UIAlertAction]()
        
        if let okButtonName = okButtonName {
            let name = okButtonName.isEmpty ? okDefaultName : okButtonName
            let style: UIAlertAction.Style = isOkDestructive == true ? .destructive : .default
            
            allButtons.append(UIAlertAction(title: name, style: style) { (_) in
                completion?()
            })
        }
        
        if !customButtons.isEmpty {
            allButtons += customButtons
        }
        
        if isCancelButton == true {
            let style: UIAlertAction.Style = preferredStyle == .alert ? .default : .cancel
            
            allButtons.append(UIAlertAction(title: cancelDefaultName, style: style))
        }
        
        for button in allButtons {
            alert.addAction(button)
        }
        
        if allButtons.isEmpty {
            alert.addAction(UIAlertAction(title: okDefaultName, style: .cancel) { (_) in
                completion?()
            })
        }
        
        addActionSheetForiPad(actionSheet: alert)
        present(alert, animated: true)
    }
    
    enum AlertType {
        case alert(title: String, message: String)
        case localizedError(LocalizedError)
        case NSError(NSError)
    }
}

