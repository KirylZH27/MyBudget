//
//  UIStackView+MyStyle .swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 12.07.23.
//

import UIKit

extension UIStackView {
    
    public func myStyleStack(spacing: CGFloat, aligment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, userInteraction: Bool) -> Self {
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = aligment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = userInteraction
        return self
    }
    
    public func setLayoutMargins(top: CGFloat, left: CGFloat, right: CGFloat, bottom: CGFloat) -> Self {
        self.layoutMargins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        self.isLayoutMarginsRelativeArrangement = true
        return self
    }
}
