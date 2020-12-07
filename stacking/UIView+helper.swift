//
//  UIView+helper.swift
//  stacking
//
//  Created by Salah Amassi on 05/12/2020.
//

import UIKit

extension UIView {

    func drawDebugingBorder(with color: UIColor) -> UIView {
        let debugView = UIView()
        debugView.layer.borderColor = color.cgColor
        debugView.layer.borderWidth = 1
        debugView.addSubview(self)
        fillSuperview()
        return debugView
    }
    
    
    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0, maskedCorners: CACornerMask? = nil){
        if let maskedCorners = maskedCorners{
            layer.cornerRadius = blur
            layer.maskedCorners = maskedCorners
        }
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        layer.masksToBounds = false
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

}
