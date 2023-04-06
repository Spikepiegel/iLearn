//
//  VoiceAppArchieverService.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.04.2023.
//

import Foundation

final class VoiceAppArchiever {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var key: String
    
    init(key: String) {
        self.key = key
    }
    
    //MARK: - Public methods
    func save(_ selectedTheme: String) {
        
        do {
            let data = try encoder.encode(selectedTheme)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> String {
        
        //Data -> Array<Word>
        guard let data = UserDefaults.standard.data(forKey: key) else { return "com.apple.ttsbundle.siri_male_en-US_compact" }
        do {
            let array = try decoder.decode(String.self, from: data)
            return array
        } catch {
            print(error)
        }
        return "Blue Skies"
    }
}
