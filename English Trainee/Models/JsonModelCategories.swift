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
    let origin, translation: String
    let transcription: String?
    let image, example: String
    var isLearned: Bool?
    var translationIsHShown: Bool?
}

/// Random Words Model

struct RandomWords: Codable {
    let randomWords: [RandomWordElement]
}


///Model of Random Words for the Quize Game
struct RandomWordElement: Codable {
    let word: String
}


///App Pronounciation Voices
struct AppVoices: Codable {
    let voiceInformation: [Voice]
}

struct Voice: Codable {
    let id: UInt
    let voiceLanguage: String
    let voiceName: String
    let voiceIdentifier: String
}
