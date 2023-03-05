//
//  QuestionUpdater.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 05.03.2023.
//

import Foundation

class QuestionUpdater {
    
    var fullWordsInformationList: [Word]
    
    init(fullWordsInformationList: [Word]) {
        self.fullWordsInformationList = fullWordsInformationList
    }
    
    func createEnglishWordsArray() -> [String] {
        var englishWords: [String] = []
        for words in fullWordsInformationList {
            englishWords.append(words.origin)
        }
        return englishWords
    }
    
    func createQuestion(_ numberOfQuestion: Int) -> String{
        return fullWordsInformationList[numberOfQuestion].translation
    }
    
    func createAnswersArray(_ numberOfQuestion: Int) -> [String] {
        var buttonsTitleArray: [String] = []
        let service = RandomWordsJsonService().loadRandomJsonWords(filename: "Random Words")
        for _ in 0..<3 {
            buttonsTitleArray.append(service?.randomElement()?.word ?? "unknown")
        }
        buttonsTitleArray.append(fullWordsInformationList[numberOfQuestion].origin)
        buttonsTitleArray.shuffle()
        return buttonsTitleArray
    }
    
    
    
}
