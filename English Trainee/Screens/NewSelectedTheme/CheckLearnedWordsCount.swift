//
//  CheckLearnedWordsCount.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 05.03.2023.
//

import Foundation

class CheckLearnedWordsCount {
    
    var wordsList: [Word]
    var counter: UInt = 0
    
    init(wordsList: [Word]) {
        self.wordsList = wordsList
    }
    
    func calculateLearnedWords() -> UInt {
        for learnedCount in wordsList {
            if learnedCount.isLearned ?? false {
                counter += 1
            }
        }
        
        return counter
    }
}
