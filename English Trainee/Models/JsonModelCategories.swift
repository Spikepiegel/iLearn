//
//  JsonModel.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 21.02.2023.
//

import Foundation


import Foundation

///All Categories Model
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

/// Selected Category Words Model

struct CategoryWordsList: Codable {
    let wordInformation: [Word]
}

struct Word: Codable {
    let id: UInt
    let origin, translation, transcription, image, example: String
    var isLearned: Bool?
    var translationIsHidden: Bool?
}

/// Random Words Model

struct RandomWords: Codable {
    let randomWords: [RandomWordElement]
}

// MARK: - RandomWordElement
struct RandomWordElement: Codable {
    let word: String
}
