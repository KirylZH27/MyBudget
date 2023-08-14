//
//  TransactionWasAddedAnimationViewControllerView.swift
//  MyBudget
//
//  Created by Кирилл Жогальский on 28.07.23.
//

import UIKit

final class TransactionWasAddedAnimationViewControllerView: NiblessView {
    
    let outerRingAnimationDuration: Double = 1.5
    let outerRingBorderWidth: CGFloat = 24
    let outerRingViewSide: CGFloat = 220
    
    lazy var insideViewSide: CGFloat = outerRingViewSide - outerRingBorderWidth * 2
    lazy var insideAnimationDuration: Double = outerRingAnimationDuration * 1.2
    
    lazy var dollarImageViewSide: CGFloat = insideViewSide * 0.8
    let dollarImageAnimationDuration: Double = 1.5
    
    private let appColorGetter: AppColorGetter
    
   lazy var outerRingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = outerRingViewSide / 2
       view.layer.borderWidth = outerRingBorderWidth
       view.layer.borderColor = UIColor.gray.cgColor
       view.backgroundColor = .white
       view.layer.shadowRadius = 20
       view.layer.shadowColor = AppColors.black.value.cgColor
       view.layer.shadowOpacity = 0.5
       view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var insideView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = insideViewSide / 2
        view.backgroundColor = appColorGetter.getMainColor()
        return view
     }()
    
    lazy var dollarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "dollarsign")
        imageView.alpha = 0
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        appColorGetter = UserDefaultAppColorDataSource()
        super.init(frame: frame)
        backgroundColor = .clear
        
        layoutElements()
    }
    
    private func layoutElements(){
        layoutOuterRingView()
        layoutInsideView()
        layoutDollarImageView()
    }
    
    func startAnimation(completion: @escaping () -> Void){
        scaleOuterRingView()
        scaleInsideView(increaseCompletion: {
            self.animateDollar(completion: {
                completion()
            })
        })
    }
    
    private func scaleOuterRingView(){
        outerRingView.transform = CGAffineTransform(scaleX: 0, y: 0)
        let increaseDuration = outerRingAnimationDuration * 0.8
        let decreaseDuration = outerRingAnimationDuration * 0.2
        
        UIView.animate(withDuration: increaseDuration) {
            self.outerRingView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        } completion: { _ in
            UIView.animate(withDuration: decreaseDuration) {
                self.outerRingView.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func scaleInsideView(increaseCompletion: @escaping () -> Void){
        insideView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let increaseDuration = insideAnimationDuration * 0.8
        let decreaseDuration = insideAnimationDuration * 0.2
        
        UIView.animate(withDuration: increaseDuration) {
            self.insideView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        } completion: { _ in
            increaseCompletion()
            UIView.animate(withDuration: decreaseDuration) {
                self.insideView.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func animateDollar(completion: @escaping () -> Void) {
        dollarImageView.alpha = 1
        dollarImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let increaseDuration = dollarImageAnimationDuration * 0.8
        let decreaseDuration = dollarImageAnimationDuration * 0.2
        
        self.dollarImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.1, y:  0.1)
            UIView.animate(withDuration: increaseDuration) {
                self.dollarImageView.transform = CGAffineTransform.identity
            } completion: { _ in
                sleep(1)
                completion()
            }
        }
    
    private func layoutOuterRingView(){
        addSubview(outerRingView)
        NSLayoutConstraint.activate([
            outerRingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            outerRingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            outerRingView.widthAnchor.constraint(equalToConstant: outerRingViewSide),
            outerRingView.heightAnchor.constraint(equalToConstant: outerRingViewSide)
        ])
    }
    
    private func layoutInsideView(){
        addSubview(insideView)
        NSLayoutConstraint.activate([
            insideView.centerXAnchor.constraint(equalTo: centerXAnchor),
            insideView.centerYAnchor.constraint(equalTo: centerYAnchor),
            insideView.widthAnchor.constraint(equalToConstant: insideViewSide),
            insideView.heightAnchor.constraint(equalToConstant: insideViewSide)
        ])
    }
    
    private func layoutDollarImageView(){
        addSubview(dollarImageView)
        NSLayoutConstraint.activate([
            dollarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dollarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dollarImageView.widthAnchor.constraint(equalToConstant: dollarImageViewSide),
            dollarImageView.heightAnchor.constraint(equalToConstant: dollarImageViewSide)
        ])
    }
}
