//
//  PhotoCollectionCell.swift
//  RXSwiftPhotoApp
//
//  Created by Kingsley Charles on 18/03/2021.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    lazy var imageCotainer: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageCotainer)
        imageCotainer.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
