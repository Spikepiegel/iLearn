//
//  JSONService.swift
//  EnglishQuiz
//
//  Created by MacBookAir on 21.01.2023.
//

import Foundation

protocol JsonServiceProtocol: AnyObject {
    func loadJsonCategories(filename fileName: String) -> [Item]?
    func loadJsonWords(filename fileName: String) -> [Word]?

}



///Get data with all categories JSON
class JsonServiceImpl: JsonServiceProtocol {
    
    func loadJsonCategories(filename fileName: String) -> [Item]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(Themes.self, from: data)
                return jsonResponse.item
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

///Get data about selected category JSON

extension JsonServiceImpl {
    
    func loadJsonWords(filename fileName: String) -> [Word]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(CategoryWordsList.self, from: data)
                return jsonResponse.wordInformation
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

///Get data about random words JSON


class RandomWordsJsonService {
    func loadRandomJsonWords(filename fileName: String) -> [RandomWordElement]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(RandomWords.self, from: data)
                print(jsonResponse.randomWords)
                return jsonResponse.randomWords
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

class VoiceJsonService {
    func loadRandomJsonWords(filename fileName: String) -> [Voice]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(AppVoices.self, from: data)
                print(jsonResponse.voiceInformation.count)
                return jsonResponse.voiceInformation
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
