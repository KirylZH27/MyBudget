//
//  BlockTap.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 8.07.23.
//

import UIKit
//БлокТап - нужен что бы сделать кликабельной картинку из профиля на экране редактирования профиля.
class BlockTap: UITapGestureRecognizer {
    fileprivate var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init (tapCount: Int = 1,
                             fingerCount: Int = 1,
                             action: ((UITapGestureRecognizer) -> Void)?) {
        
        self.init()
        self.numberOfTapsRequired = tapCount
        
        #if os(iOS)
        self.numberOfTouchesRequired = fingerCount
        #endif
        
        self.tapAction = action
        self.addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }
    
    @objc open func didTap (_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}


extension UIView {
    
    public func addTapGesture(tapNumber: Int = 1,
                              action: ((UITapGestureRecognizer) -> ())?) {
        
        let tap = BlockTap(tapCount: tapNumber,
                           fingerCount: 1,
                           action: action)
        
        addGestureRecognizer(tap)
    }
}
