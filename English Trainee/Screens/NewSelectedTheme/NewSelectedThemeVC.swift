//
//  NewSelectedThemeVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.04.2023.
//
//
// 1. Configure Views - Root View
// 2. Layout Views - Root View
// 3. Update Views - Root View
//
// 4. Update Model - VC
//
// 5. Navigation - VC
//
// 6. Busness Logic - Services
//
// 7. Event Handling - VC
//
// 8. Configure Module - VC
//
// 9. State Pattern (loading, loaded, empty, error) -
//
// 10. Delegate/Datasource - VC
//
// 11. DI container - VC
//
// */

import Foundation
import UIKit
import AVFAudio


protocol SelectedThemeVCProtocol {
    //func openQuizeGameVC(_ gameType: String)
    //func soundWord(_ soundedWord: String)
    func addNewWord(_ origin: String, _ translation: String, _ transcription: String?)
}


class NewSelectedThemeVC: UIViewController, SelectedThemeVCProtocol {
    
    var selectedCategoryName: String
    
    var jsonService: JsonServiceProtocol?
    
    var selectedThemeView: NewSelectedThemeView { return self.view as! NewSelectedThemeView }
    lazy var wordsArchiver = WordsArchiver(key: selectedCategoryName)
    var wordPopUp = AddNewUserWordPopUp()
    var header = SelectedThemeHeader()
    
    let synthesizer = AVSpeechSynthesizer()
    lazy var voiceArchiever = VoiceAppArchiever(key: "appVoice")

    var words = [Word]()
    var allTranslationsStatus = false
    
    init(selectedCategoryName: String) {
        self.selectedCategoryName = selectedCategoryName
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = NewSelectedThemeView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        words = loadWords() //Array with words of selected Category
        passWordsToTable()
        selectedThemeView.onBackButonEvent = { [weak self] in self?.closeButtonPressed() }
        selectedThemeView.onShowHideTanslationEvent = { [weak self] in self?.showHideTanslationAllWords() }
        selectedThemeView.onAddWordEvent = { [weak self] in self?.openNewWordPopUp() }        
        selectedThemeView.wordsTable.gameType = {[weak self] gameTypeName in
            self?.openQuizeGameVC(gameTypeName)
        }
        
        selectedThemeView.wordsTable.wordForSound = { [weak self] wordLabelSound in
            self?.soundWord(wordLabelSound)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedThemeView.setupGradientVC()
    }
    
}

extension NewSelectedThemeVC {
    ///Load words depending on selected category
    func loadWords() -> [Word] {
        
        let words = wordsArchiver.retrieve()
        
        if words.isEmpty {
            wordsArchiver.save(jsonService?.loadJsonWords(filename: selectedCategoryName) ?? [])
            return jsonService?.loadJsonWords(filename: selectedCategoryName) ?? []
        }
        return words
    }
    
    @objc func closeButtonPressed() {
        
        for index in 0..<words.count {
            words[index].translationIsHShown = false
        }
        
        wordsArchiver.save(words)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func passWordsToTable() {
        selectedThemeView.passWordsToTable(words, selectedCategoryName)
    }
    
    func showHideTanslationAllWords() {
        switch allTranslationsStatus {
        case false:
                selectedThemeView.showHideTranslationButton.setImage(UIImage(named: "hide"), for: .normal)
            for index in 0..<words.count {
                words[index].translationIsHShown = true
            }
            passWordsToTable()
            allTranslationsStatus = true
            selectedThemeView.wordsTable.reloadData()
            
        case true:
            
            selectedThemeView.showHideTranslationButton.setImage(UIImage(named: "show"), for: .normal)
            for index in 0..<words.count {
                words[index].translationIsHShown = false
            }
            passWordsToTable()
            allTranslationsStatus = false
            selectedThemeView.wordsTable.reloadData()
        }
    }
}

extension NewSelectedThemeVC {
    func openNewWordPopUp() {
        let vc = AddNewUserWordPopUp()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    func addNewWord(_ origin: String, _ translation: String, _ transcription: String?) {
        words.append(Word(id: 1, origin: origin, translation: translation, transcription: transcription, image: " ", example: " "))
        words = words.sorted {$0.origin < $1.origin}
        
        passWordsToTable()
        wordsArchiver.save(words)
        selectedThemeView.wordsTable.reloadData()
        selectedThemeView.wordsTable.header.progressLabel.text = "Progress     \(selectedThemeView.wordsTable.getLearnedWordsCount()) / \(loadWords().count)"
    }
    
    
    func openQuizeGameVC(_ gameType: String) {
        
        ///Gets list of the whole words
        let archWord = WordsArchiver(key: selectedCategoryName).retrieve()
        ///Checks how many words are maked as learned
        let checkLearnedWords = CheckLearnedWordsCount(wordsList: archWord).calculateLearnedWords()
        
        if gameType == "Practice the learned words" && checkLearnedWords > 0 {
            
            let vc = QuizeGameVC(gameType: gameType, selectedTheme: selectedCategoryName)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
            
        } else if gameType == "Practice the learned words" && checkLearnedWords == 0 {
            let vc = NoLearnedWordsPopUp()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
        
        if gameType == "Practice all words" {
            
            let vc = QuizeGameVC(gameType: gameType, selectedTheme: selectedCategoryName)
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
            
        }
    }
    
    func soundWord(_ soundedWord: String) {
        let utterance = AVSpeechUtterance(string: soundedWord)
        utterance.voice = AVSpeechSynthesisVoice(identifier: voiceArchiever.retrieve())
        utterance.rate = 0.3
        
        synthesizer.speak(utterance)
    }
}
