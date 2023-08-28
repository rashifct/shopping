//
//  HomeDataResponse.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import Foundation

struct HomeDataResponse: Codable {
    var status: Bool
    var homeData: [HomeDatum]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case homeData = "homeData"
    }
}

struct HomeDatum: Codable {
    var type: String
    var values: [Value]

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case values = "values"
    }
}

struct Value: Codable {
    var id: Int
    var name: String?
    var imageURL: String?
    var bannerURL: String?
    var image: String?
    var actualPrice: String?
    var offerPrice: String?
    var offer: Int?
    var isExpress: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image_url"
        case bannerURL = "banner_url"
        case image = "image"
        case actualPrice = "actual_price"
        case offerPrice = "offer_price"
        case offer = "offer"
        case isExpress = "is_express"
    }
}
