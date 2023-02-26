//
//  JsonModel.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 21.02.2023.
//

import Foundation


import Foundation

// MARK: - All Categories
struct Themes: Codable {
    let item: [Item]
}

class Item: Codable {
    let id: Int
    let themes: [Theme]
}

class Theme: Codable {
    let name: String
}

// MARK: - Basic Words Category

struct CategoryWordsList: Codable {
    let wordInformation: [WordInformation]
}

struct WordInformation: Codable {
    let id: Int
    let origin, translation, transcription, image, example: String
}
