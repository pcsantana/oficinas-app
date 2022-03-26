//
//  UIView+Extension.swift
//  HinovaOficinas
//
//  Created by Paulo Santana on 24/03/22.
//

import UIKit

extension UIView {
    
    func adicionarBorda(cornerRadius: CGFloat, color: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
