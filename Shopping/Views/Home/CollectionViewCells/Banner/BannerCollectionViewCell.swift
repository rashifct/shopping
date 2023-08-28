//
//  BannerCollectionViewCell.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with value: Value) {
        
        if let imageURL = value.bannerURL, let url = URL(string: imageURL) {
            bannerImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))]) { result in
                switch result {
                case .success(_):
                    self.animateCellAppearance()
                case .failure(_):
                    self.bannerImageView.image = nil
                }
            }
        } else {
            bannerImageView.image = nil
        }
    }
    
    func animateCellAppearance() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }, completion: nil)
    }
    
}
