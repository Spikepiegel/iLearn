//
//  JSONService.swift
//  EnglishQuiz
//
//  Created by MacBookAir on 21.01.2023.
//

import Foundation

protocol JsonServiceProtocol {
    func loadJsonCategories(filename fileName: String) -> [Item]?
    func loadJsonWords(filename fileName: String) -> [WordInformation]?

}



//MARK: - Get data with all categories
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

//MARK: - Get data about "Basic Words" category

extension JsonServiceImpl {
    
    func loadJsonWords(filename fileName: String) -> [WordInformation]? {
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
