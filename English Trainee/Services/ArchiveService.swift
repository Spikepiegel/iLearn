//
//  ArchiveService.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 05.03.2023.
//

import Foundation

//Класс-сервис - бизнес-логика - архивируем массив участников

//protocol WordsArchiver {
//    func save(_ Words: [Friend])
//    func retrieve() -> [Friend]
//}

final class WordsArchiver {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var key: String
    
    init(key: String) {
        self.key = key
    }
    
    //MARK: - Public methods
    func save(_ words: [Word]) {
        
        //Array<Student> -> Data
        do {
            let data = try encoder.encode(words)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [Word] {
        
        //Data -> Array<Student>
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Word>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
}
