//
//  File.swift
//  RXSwiftPhotoApp
//
//  Created by Kingsley Charles on 18/03/2021.
//

import UIKit


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, size: CGSize = .zero, padding: UIEdgeInsets = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchorConstraint = top {
            topAnchor.constraint(equalTo: topAnchorConstraint, constant: padding.top).isActive = true
        }
        if let trailingAnchorConstraint = trailing {
            trailingAnchor.constraint(equalTo: trailingAnchorConstraint, constant: -padding.right).isActive = true
        }
        if let leadingAnchorConstraint = leading {
            leadingAnchor.constraint(equalTo: leadingAnchorConstraint, constant: padding.left ).isActive = true
        }
        if let bottomAnchorConstraint = bottom {
            bottomAnchor.constraint(equalTo: bottomAnchorConstraint, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
