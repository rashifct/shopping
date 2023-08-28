//
//  ProdcutCellViewModel.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import Foundation

class ProductCellViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    
    let product: Value
    
    init(product: Value) {
        self.product = product
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
    }
}

