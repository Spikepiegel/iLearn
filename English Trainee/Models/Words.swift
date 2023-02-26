//
//  Words.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 08.02.2023.
//

import Foundation


struct Question {
    var word: String
    var answers: [Answer]
}

struct Answer {
    var text: String
    var isCorrect: Bool
}

class QuestionService {
    
    var score : Int = 0
    var questionNumber: Int = 1
    
    var questions = [Question(word: "condition",
                              answers: [
                                Answer(text: "Соответствие", isCorrect: false),
                                Answer(text: "Условие", isCorrect: true),
                                Answer(text: "Отношение", isCorrect: false),
                                Answer(text: "Беспокойство", isCorrect: false)]),
                     Question(word: "dry",
                              answers: [
                                Answer(text: "Милый", isCorrect: false),
                                Answer(text: "Сухой", isCorrect: true),
                                Answer(text: "Красивый", isCorrect: false),
                                Answer(text: "Влажный", isCorrect: false)]),
                     Question(word: "contain",
                              answers: [
                                Answer(text: "Приносить", isCorrect: false),
                                Answer(text: "Причинять", isCorrect: false),
                                Answer(text: "Содержать", isCorrect: true),
                                Answer(text: "Баловаться", isCorrect: false)]),
                     Question(word: "catch",
                              answers: [
                                Answer(text: "Плавать", isCorrect: false),
                                Answer(text: "Ловить", isCorrect: true),
                                Answer(text: "Торопиться", isCorrect: false),
                                Answer(text: "Учить", isCorrect: false)]),
                     Question(word: "practice",
                              answers: [
                                Answer(text: "Прятаться", isCorrect: false),
                                Answer(text: "Практиковаться", isCorrect: true),
                                Answer(text: "Выполнять", isCorrect: false),
                                Answer(text: "Быть", isCorrect: false)])
    ]
    
    func getAnswer(_ selectedAnswer : String, _ questionNumber: Int) -> Bool{
        let question = questions[questionNumber].answers
        for check in question {
 
            if selectedAnswer == check.text {
                if check.isCorrect {
                    score += 1
                    return true
                } else {
                    return false
                }
            }
            
        }
        return true
    }
    
    func getScore() {
        score += 1
    }
    
    func getQuestionNumber() {
        return questionNumber += 1
    }
    
}
