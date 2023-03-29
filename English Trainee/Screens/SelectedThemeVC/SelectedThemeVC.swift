//
//  SelectedThemeVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 23.02.2023.
//

import UIKit
import SnapKit
import AVFoundation

protocol SelectedThemeVCProtocol {
    func openQuizeGameVC(_ gameType: String)
    func soundWord(_ soundedWord: String)
    func addNewWord(_ origin: String, _ translation: String, _ transcription: String?)
}

/// VC with selected category
class SelectedThemeVC: UIViewController {
    let synthesizer = AVSpeechSynthesizer()

    //easy cohesion
    var jsonService: JsonServiceProtocol?
    lazy var voiceArchiever = VoiceAppArchiever(key: "appVoice")
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    lazy var wordsArchiver = WordsArchiver(key: selectedTheme)
    
    var header = SelectedThemeHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 310))
    ///List with words of selected category. Data is gotten from JSON by loadWords method
    var words = [Word]()
    var allTranslationsStatus = false
    ///Accepts the name of theme which user has selected
    var selectedTheme: String
        
    
    lazy var wordsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SelectedThemeCell.self, forCellReuseIdentifier: SelectedThemeCell.identifier)
        tableView.backgroundColor = .clear
        let headerView = header
        headerView.delegate = self  //delegate to open game screen
        tableView.tableHeaderView = headerView
        headerView.themeLabel.text = selectedTheme
        header.updateTheme(theme: selectedTheme)
        headerView.progressLabel.text = "Progress     \(getLearnedWordsCount()) / \(loadWords().count)"
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var showHideTranslationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setImage(UIImage(named: "show"), for: .normal)
        

        
        button.addTarget(self, action: #selector(showHideAllWordsTranslation), for: .touchUpInside)
        return button
    }()
    
    @objc func showHideAllWordsTranslation(sender: UIButton!) {
        
        switch allTranslationsStatus {
        case false:
            showHideTranslationButton.setImage(UIImage(named: "hide"), for: .normal)
            for index in 0..<words.count {
                words[index].translationIsHShown = true
            }
            allTranslationsStatus = true
            wordsTable.reloadData()
            
        case true:
            
            showHideTranslationButton.setImage(UIImage(named: "show"), for: .normal)
            for index in 0..<words.count {
                words[index].translationIsHShown = false
            }
            allTranslationsStatus = false
            wordsTable.reloadData()
        }
        
    }
    
    lazy var addWordButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.setImage(UIImage(named: "addWord"), for: .normal)
        
        button.addTarget(self, action: #selector(addWord), for: .touchUpInside)
        return button
    }()
    
    @objc func addWord(sender: UIButton!) {
        let vc = AddNewUserWordPopUp()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    //MARK: - Lifecycle
    
    init(selectedTheme: String) {
        self.selectedTheme = selectedTheme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupGradientVC()
        wordsTable.reloadData()
    }
    
    @objc func closeButtonPressed(sender: UIButton!) {
        for index in 0..<words.count {
            words[index].translationIsHShown = false
        }
        
        wordsArchiver.save(words)
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        words = loadWords() //Array with words of selected Category
        header.themeLabel.text = selectedTheme
        
    }
    
    //MARK: Fetch Data from json with words of selected theme
    func loadWords() -> [Word] {
        
        let words = wordsArchiver.retrieve()
        
        if words.isEmpty {
            wordsArchiver.save(jsonService?.loadJsonWords(filename: selectedTheme) ?? [])
            return jsonService?.loadJsonWords(filename: selectedTheme) ?? []
        }
        return words
    }
    
    func getLearnedWordsCount() -> UInt {
        let learnedWords = CheckLearnedWordsCount(wordsList: loadWords())
        return learnedWords.calculateLearnedWords()
    }
    
    func update() {
        header.progressLabel.text = "Progress     \(getLearnedWordsCount()) / \(loadWords().count)"
    }
    
}

extension SelectedThemeVC {
    
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(backButton)
        view.addSubview(addWordButton)
        view.addSubview(showHideTranslationButton)
        view.addSubview(wordsTable)
        wordsTable.layer.cornerRadius = 15
        
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.left.equalTo(view).inset(20)
        }
        
        addWordButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.right.equalTo(view).inset(20)
        }
        
        showHideTranslationButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.right.equalTo(view).inset(75)
        }
        
        wordsTable.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(55)
            make.left.right.bottom.equalTo(view)
        }
    }
    
}

extension SelectedThemeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedThemeCell.identifier, for: indexPath) as? SelectedThemeCell  else {
            return UITableViewCell() }
        
        cell.soundDelegate = self
        let word = words[indexPath.row]
        cell.update(word)
        cell.backgroundColor = .clear
        
        if words[indexPath.row].isLearned ?? false {
            cell.learnedWordImage.image = UIImage(named: "done")
        } else if words[indexPath.row].isLearned == false || words[indexPath.row].isLearned == nil {
            cell.learnedWordImage.image = UIImage(named: "unDone")
        }
        cell.setupGradientVC()
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.cellForRow(at: indexPath) as! SelectedThemeCell
        let done = UIContextualAction(style: .destructive, title: "") { (action, view, complete) in
            
            if self.words[indexPath.row].isLearned == nil || self.words[indexPath.row].isLearned == false {
                self.words[indexPath.row].isLearned = true
                cell.learnedWordImage.setImageAnimation(UIImage(named: "done"))
                
                
            } else if self.words[indexPath.row].isLearned == true {
                self.words[indexPath.row].isLearned?.toggle()
                cell.learnedWordImage.setImageAnimation(UIImage(named: "unDone"))

            }
            self.wordsArchiver.save(self.words)
            self.update()
            complete(true)
        }
        
        done.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        if cell.learnedWordImage.image == UIImage(named: "done") {
            let crossImage = UIImage(named: "cross")
            crossImage?.withTintColor(.systemPink, renderingMode: .alwaysTemplate)
            
            done.image = crossImage
        } else {
            done.image = UIImage(named: "done")
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [done])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, complete) in
            self.words.remove(at: indexPath.row)
            self.wordsTable.deleteRows(at: [indexPath], with: .fade)
            self.wordsTable.endUpdates()
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

extension SelectedThemeVC: UITableViewDataSource {
    
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

extension SelectedThemeVC: SelectedThemeVCProtocol {
    
    
    
    /// Method opens the game which user has selected
    func openQuizeGameVC(_ gameType: String) {
        
        ///Gets list of the whole words
        let archWord = WordsArchiver(key: selectedTheme).retrieve()
        ///Checks how many words are maked as learned
        let checkLearnedWords = CheckLearnedWordsCount(wordsList: archWord).calculateLearnedWords()
        
        if gameType == "Practice the learned words" && checkLearnedWords > 0 {
            
            let vc = QuizeGameVC(gameType: gameType, selectedTheme: selectedTheme)
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
            
            let vc = QuizeGameVC(gameType: gameType, selectedTheme: selectedTheme)
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
    
    func addNewWord(_ origin: String, _ translation: String, _ transcription: String?) {
        let vc = AddNewUserWordPopUp()
        vc.delegate = self
        words.append(Word(id: 1, origin: origin, translation: translation, transcription: transcription, image: " ", example: " "))
        words = words.sorted {$0.origin < $1.origin}
        
        wordsArchiver.save(words)
        wordsTable.reloadData()
        header.progressLabel.text = "Progress     \(getLearnedWordsCount()) / \(loadWords().count)"
    }
    

}

///Gradient Settings
extension SelectedThemeVC {
    func setupGradientVC() {
        let gradientLayer = CAGradientLayer()
        
        guard let gradientSubLayer = view.layer.sublayers else { return }
        if gradientSubLayer.count > 4 {
            gradientSubLayer[0].removeFromSuperlayer()
        }
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            

            let colorTop =  UIColor.leftAppBackgroundColor.cgColor
            let colorBottom = UIColor.rightAppBackgroundColor.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            backButton.tintColor = .black
            addWordButton.tintColor = .black
            showHideTranslationButton.tintColor = .black
            wordsTable.separatorColor = .black
            
        case "Classic Black":
            let colorTop =  UIColor.black.cgColor
            let colorBottom = UIColor.black.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            backButton.tintColor = .white
            addWordButton.tintColor = .white
            showHideTranslationButton.tintColor = .white
            
            wordsTable.separatorColor = .lightGray

        case "Classic White":
            let colorTop =  UIColor.whiteTheme.cgColor
            let colorBottom = UIColor.whiteTheme.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
            backButton.tintColor = .black
            addWordButton.tintColor = .black
            showHideTranslationButton.tintColor = .black
            
            wordsTable.separatorColor = .black

        default:
            return
        }
    }
}
