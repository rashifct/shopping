//
//  ProductsCollectionViewCell.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import UIKit
import Combine
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerView: NotchedTriangleView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var expressView: UIView!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModel: ProductCellViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFavorite in
                self?.updateFavoriteButton(isFavorite: isFavorite)
            }
            .store(in: &cancellables)
        
        configure(with: viewModel.product)
    }
    
    func configure(with value: Value) {
        if let imageURL = value.image ?? value.imageURL, let url = URL(string: imageURL) {
            productImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))]) { result in
                if case .success(_) = result {
                    self.animateCellAppearance()
                } else {
                    self.productImageView.image = nil
                }
            }
        } else {
            productImageView.image = nil
        }
        
        productNameLabel.text = value.name
        
        let hasOffer = value.offer != nil && value.offer! > 0
        let shouldHideOffer = value.actualPrice == value.offerPrice || !hasOffer
        
        offerPriceLabel.text = shouldHideOffer ? nil : value.offerPrice?.replacingOccurrences(of: " ", with: "")
        offerPriceLabel.isHidden = shouldHideOffer
        offerView.isHidden = shouldHideOffer
        offerLabel.text = hasOffer ? "\(value.offer!)% OFF" : nil
        
        actualPriceLabel.alpha = hasOffer ? 0.5 : 1.0
        actualPriceLabel.font = hasOffer ? UIFont.systemFont(ofSize: actualPriceLabel.font.pointSize) : UIFont.boldSystemFont(ofSize: actualPriceLabel.font.pointSize)
        actualPriceLabel.text = value.actualPrice?.replacingOccurrences(of: " ", with: "")

        expressView.isHidden = !(value.isExpress ?? false)
    }
    
    @IBAction func favouriteButtonClicked(_ sender: UIButton) {
        viewModel.toggleFavorite()
    }
    
    private func updateFavoriteButton(isFavorite: Bool) {
        let tintColor = isFavorite ? UIColor.red : UIColor.lightGray
        favoriteButton.tintColor = tintColor
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
