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
}
