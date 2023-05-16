//
//  Image Model.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 14.05.2023.
//

import Foundation


// MARK: - PhotoResponse
//struct PhotoResponse: Codable {
//    let totalResults, page, perPage: Int?
//    let photos: [Photo]
//    let nextPage: String
//
//    enum CodingKeys: String, CodingKey {
//        case totalResults = "total_results"
//        case page
//        case perPage = "per_page"
//        case photos
//        case nextPage = "next_page"
//    }
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let id, width, height: Int
//    let url: String
//    let photographer: String
//    let photographerURL: String
//    let photographerID: Int
//    let avgColor: String
//    let src: Src
//    let liked: Bool
//    let alt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, width, height, url, photographer
//        case photographerURL = "photographer_url"
//        case photographerID = "photographer_id"
//        case avgColor = "avg_color"
//        case src, liked, alt
//    }
//}
//
//// MARK: - Src
//struct Src: Codable {
//    let original, large2X, large, medium: String
//    let small, portrait, landscape, tiny: String
//
//    enum CodingKeys: String, CodingKey {
//        case original
//        case large2X = "large2x"
//        case large, medium, small, portrait, landscape, tiny
//    }
//}


// MARK: - PhotoResponse
//struct PhotoResponse: Decodable {
//    let total, totalPages: Int
//    let results: [UnsplashImage]
//
//}
//
//// MARK: - Result
//struct UnsplashImage: Decodable {
//    let width, height: Int
//    //let urls: [URLKing.RawValue: String]
//
//    enum URLKing: String {
//        case raw
//        case full
//        case regular
//        case small
//        case thumb
//    }
//}

struct PhotoResponse: Codable {
    let total, totalPages: Int
    let results: [UnsplashImage]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
struct UnsplashImage: Codable {
    let id: String
    let width, height: Int
    let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id
        case width, height
        case urls
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
