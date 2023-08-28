//
//  CategoryCollectionViewCell.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureBorderView()
    }
    
    func configure(with value: Value) {
        categoryNameLabel.text = value.name ?? ""
        
        if let imageURL = value.imageURL, let url = URL(string: imageURL) {
            categoryImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))]) { result in
                switch result {
                case .success(_):
                    self.animateCellAppearance()
                case .failure(_):
                    self.categoryImageView.image = nil
                }
            }
        } else {
            categoryImageView.image = nil
        }
    }
    
    private func configureBorderView() {
        borderView.backgroundColor = getRandomLightColor()
        borderView.layer.cornerRadius = borderView.frame.width / 2.0
        borderView.layer.masksToBounds = true
    }
    
    private func getRandomLightColor() -> UIColor {
        let hue = CGFloat.random(in: 0...1)
        let saturation = CGFloat.random(in: 0...0.2)
        let brightness = CGFloat.random(in: 0.9...1)
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    private func animateCellAppearance() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }, completion: nil)
    }
}
