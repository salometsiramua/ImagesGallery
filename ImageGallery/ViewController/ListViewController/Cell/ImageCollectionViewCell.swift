//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Salome Tsiramua on 3/11/21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var galleryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

protocol ImageCollectionViewCellConfigurable {
    func configure(with model: ImageCollectionViewCellViewModel)
}

extension ImageCollectionViewCell: ImageCollectionViewCellConfigurable {
    
    func configure(with model: ImageCollectionViewCellViewModel) {
        galleryImageView.image = model.image.image
        galleryImageView.backgroundColor = .yellow
    }
}
