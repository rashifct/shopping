//
//  HomeViewController.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var viewModel = HomeViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        bindViewModel()
    }
    
    private func registerCells() {
        categoriesCollectionView.register(UINib(nibName: CellIdentifier.category, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.category)
        bannerCollectionView.register(UINib(nibName: CellIdentifier.banner, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.banner)
        productsCollectionView.register(UINib(nibName: CellIdentifier.product, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.product)
    }
    
    private func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.categoriesCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$banners
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.bannerCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.productsCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            return viewModel.categories.count
        case bannerCollectionView:
            return viewModel.banners.count
        case productsCollectionView:
            return viewModel.products.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            return dequeueCategoryCell(for: indexPath, in: collectionView)
        case bannerCollectionView:
            return dequeueBannerCell(for: indexPath, in: collectionView)
        case productsCollectionView:
            return dequeueProductCell(for: indexPath, in: collectionView)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func dequeueCategoryCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.category, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = viewModel.categories[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
    private func dequeueBannerCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.banner, for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let banner = viewModel.banners[indexPath.item]
        cell.configure(with: banner)
        return cell
    }
    
    private func dequeueProductCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.product, for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = viewModel.products[indexPath.item]
        let cellViewModel = ProductCellViewModel(product: product)
        cell.viewModel = cellViewModel
        return cell
    }
}
