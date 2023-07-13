//
//  UIButton+Target.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 13.07.23.
//

import UIKit

extension UIButton {
    typealias Func = () -> ()
    
    public func setTarget(method methodDown: Selector, target: Any, event: UIControl.Event) -> Self {
        self.addTarget(target, action: methodDown, for: event)
        return self
    }
}
