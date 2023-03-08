//
//  CorrectAnswerCheck.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 05.03.2023.
//

import Foundation

class CorrectAnswerCheck {
    
    var answer: String
    var englishWordsArray: [String]
    
    init(answer: String, englishWordsArray: [String]) {
        self.answer = answer
        self.englishWordsArray = englishWordsArray
    }
    
    func answerChecker() -> Bool {
                
        for i in englishWordsArray {
            if i == answer {
                return true
            }
        }
        
        return false
    }
    
}
