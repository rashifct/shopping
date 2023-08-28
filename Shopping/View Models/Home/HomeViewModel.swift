//
//  HomeViewModel.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import Combine

class HomeViewModel: ObservableObject {
    @Published var categories: [Value] = []
    @Published var banners: [Value] = []
    @Published var products: [Value] = []
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        NetworkService.shared.fetchData()
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.error = err
                }
            }, receiveValue: { [weak self] (homeDataResponse: HomeDataResponse) in
                self?.categories = homeDataResponse.homeData.first(where: { $0.type == "category" })?.values ?? []
                self?.banners = homeDataResponse.homeData.first(where: { $0.type == "banners" })?.values ?? []
                self?.products = homeDataResponse.homeData.first(where: { $0.type == "products" })?.values ?? []
            })
            .store(in: &cancellables)
    }
}

