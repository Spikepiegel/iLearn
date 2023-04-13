//
//  NewSelectedThemeTable.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.04.2023.
//

import UIKit

class SelectedThemeTable: UITableView {
    
    var words = [Word]()
    var selectedCategoryName = String()
    
    var gameType: ((String) -> ())?
    var wordForSound: ((String) -> ())?
    var onTralingSwapTapped: (([Word]) -> ())?
    var onDeleteWord: ((Int) -> ())?
    
    lazy var wordsArchiver = WordsArchiver(key: selectedCategoryName)
    var header = SelectedThemeHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 310))
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    private var themesWasCreated = false

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .insetGrouped)
        setupTable()
        getGameType()
    }
    

    func setupTable() {
        self.register(SelectedThemeCell.self, forCellReuseIdentifier: SelectedThemeCell.identifier)
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.backgroundColor = .clear
        self.tableHeaderView = header
        self.layer.masksToBounds = true
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero

    }
    
    func getGameType() {
        header.onGameSelectedEvent = { gameType in
            self.gameType?(gameType)
        }
    }
    
    func loadWordsList(_ words: [Word], _ selectedCategoryName: String) {
        self.words = words
        self.selectedCategoryName = selectedCategoryName
        
        header.themeLabel.text = selectedCategoryName
        header.updateTheme(theme: selectedCategoryName)
        header.progressLabel.text = "Progress     \(getLearnedWordsCount()) / \(words.count)"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLearnedWordsCount() -> UInt {
        let learnedWords = CheckLearnedWordsCount(wordsList: words)
        return learnedWords.calculateLearnedWords()
    }
    
    func update() {
        header.progressLabel.text = "Progress     \(getLearnedWordsCount()) / \(words.count)"
    }

}

extension SelectedThemeTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedThemeCell.identifier, for: indexPath) as? SelectedThemeCell  else {
            return UITableViewCell() }
        
        let word = words[indexPath.row]
        cell.update(word)
        cell.backgroundColor = .clear
        
        if words[indexPath.row].isLearned ?? false {
            cell.learnedWordImage.image = UIImage(named: "done")
        } else if words[indexPath.row].isLearned == false || words[indexPath.row].isLearned == nil {
            cell.learnedWordImage.image = UIImage(named: "unDone")
        }
        cell.setupGradientVC()
        
        cell.onSoundWordEvent = { soundWord in
            self.wordForSound?(soundWord)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath) as! SelectedThemeCell
        let done = UIContextualAction(style: .destructive, title: "") { (action, view, complete) in
            
            if self.words[indexPath.row].isLearned == nil || self.words[indexPath.row].isLearned == false {
                self.words[indexPath.row].isLearned = true
                cell.learnedWordImage.setImageAnimation(UIImage(named: "done"))
                self.onTralingSwapTapped?(self.words)
                
            } else if self.words[indexPath.row].isLearned == true {
                self.words[indexPath.row].isLearned?.toggle()
                cell.learnedWordImage.setImageAnimation(UIImage(named: "unDone"))
                self.onTralingSwapTapped?(self.words)
            }
            self.wordsArchiver.save(self.words)
            self.update()
            complete(true)
        }
        
        done.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        if cell.learnedWordImage.image == UIImage(named: "done") {
            
            var crossImage = UIImage(named: "")

            if themeArchiever.retrieve() == "Classic White" || themeArchiever.retrieve() == "Blue Skies" {
                 crossImage = UIImage(named: "crossBlack")
            } else if themeArchiever.retrieve() == "Classic Black" {
                 crossImage = UIImage(named: "crossWhite")
            }
                        
            done.image = crossImage
        } else {
            
            if themeArchiever.retrieve() == "Classic White" || themeArchiever.retrieve() == "Blue Skies" {
                done.image = UIImage(named: "doneBlack")
            } else if themeArchiever.retrieve() == "Classic Black" {
                done.image = UIImage(named: "doneWhite")
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [done])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, complete) in
            self.words.remove(at: indexPath.row)
            self.onDeleteWord?(indexPath.row)
            self.deleteRows(at: [indexPath], with: .fade)
            self.endUpdates()
            self.wordsArchiver.save(self.words)
            self.update()
            complete(true)
        }
        
        delete.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SelectedThemeCell
                
        if words[indexPath.row].translationIsHShown == nil || words[indexPath.row].translationIsHShown == false {
            words[indexPath.row].translationIsHShown = true
            cell.wordTranslationLabel.fadeTransition(0.4)
            cell.update(words[indexPath.row])
        } else if words[indexPath.row].translationIsHShown == true {
            words[indexPath.row].translationIsHShown = false
            cell.wordTranslationLabel.fadeTransition(0.4)
            cell.update(words[indexPath.row])
        }
        
        self.wordsArchiver.save(self.words)
    }
}

extension SelectedThemeTable: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
