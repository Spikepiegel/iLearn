//
//  ViewController.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.03.2023.
//

import UIKit
import SnapKit

protocol QuizeGameVCProtocol {
    func closePupUp()
}

///Screen with quize game. Game is depended on button user has selected.
class QuizeGameVC: UIViewController, QuizeGameVCProtocol  {
    
    lazy var wordsList = getQuestionArray()
    lazy var correctAnswerVariants = QuestionUpdater(fullWordsInformationList: wordsList).createEnglishWordsArray()
    
    
    var numberOfQuestion = 0
    var score = 0
    ///Times of inccorect answers counter
    var incorrectAnswerCount = 0
    ///Answer buttons Array
    var answerButtons: [UIButton] = []
    
    var gameType, selectedTheme: String
    
    init(gameType: String, selectedTheme: String) {
        self.gameType = gameType
        self.selectedTheme = selectedTheme
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var containerStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var questionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .white
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var answersStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "\(numberOfQuestion) / \(wordsList.count)"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.center = questionStack.center
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = .blue
        progressView.center = view.center
        progressView.layer.cornerRadius = 8
        progressView.layer.masksToBounds = true
        progressView.transform = progressView.transform.scaledBy(x: 0.95, y: 3.5)
        progressView.setProgress(Float(numberOfQuestion)/Float(wordsList.count), animated: true)
        
        return progressView
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.textAlignment = .center
        label.center = questionStack.center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonPressed(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createFirstQuestion(_ wordsList: [Word]) {
        let updater = QuestionUpdater(fullWordsInformationList: wordsList)
        
        questionStack.addArrangedSubview(questionLabel)
        questionLabel.text = updater.createQuestion(numberOfQuestion)
        let answers = updater.createAnswersArray(numberOfQuestion)
        for buttonIndex in 0..<4 {
            let button = createAnswersButtons()
            button.setTitle(answers[buttonIndex], for: .normal)
            answerButtons.append(button)
            answersStack.addArrangedSubview(button)
        }
        
    }
    
    func createNextQuetion() {
        let updater = QuestionUpdater(fullWordsInformationList: wordsList)
        
        questionStack.addArrangedSubview(questionLabel)
        questionLabel.text = updater.createQuestion(numberOfQuestion)
        let answers = updater.createAnswersArray(numberOfQuestion)
        
        for buttonIndex in 0..<4 {
            answerButtons[buttonIndex].setTitle(answers[buttonIndex], for: .normal)
            
            guard let gradientLayer = answerButtons[buttonIndex].layer.sublayers else { return }
            if gradientLayer.count > 1 {
                gradientLayer[0].removeFromSuperlayer()
            }
        }
    }
    
    func createAnswersButtons() -> UIButton {
        let button = UIButton()
        button.setTitle("123", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(answerIsChoosen), for: .touchUpInside)
        return button
    }
    
    @objc func answerIsChoosen(sender: UIButton!) {
        guard let choice = sender.titleLabel?.text else { return }
        if CorrectAnswerCheck(answer: choice, englishWordsArray: correctAnswerVariants).answerChecker() {
            setGreenGradientOnAnswerButton(sender)
            numberOfQuestion += 1
            
            if incorrectAnswerCount == 0 {
                score += 1
            }
            
            if numberOfQuestion < wordsList.count{
                incorrectAnswerCount = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.createNextQuetion()
                    self.progressLabel.fadeTransition(0.3)
                    self.progressLabel.text = "\(self.numberOfQuestion) / \(self.wordsList.count)"
                    self.progressView.setProgress(Float(self.numberOfQuestion)/Float(self.wordsList.count), animated: true)
                })
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    
                    self.progressLabel.fadeTransition(0.3)
                    self.progressLabel.text = "\(self.numberOfQuestion) / \(self.wordsList.count)"
                    self.progressView.setProgress(Float(self.numberOfQuestion)/Float(self.wordsList.count), animated: true)
                    
                    let vc = ResultPopUp()
                    vc.delegate = self
                    vc.popText.text = "\(self.score)/\(self.wordsList.count) correct answers"
                    vc.modalPresentationStyle = .overCurrentContext
                    self.present(vc, animated: false) })
            }
        } else {
            setRedGradientOnAnswerButton(sender)
            incorrectAnswerCount += 1
        }
        
    }
    
    ///Method to create list of the words depending of the type of the game
    func getQuestionArray() -> [Word] {
        let service = WordsArchiver(key: selectedTheme)
        let gameAllWordsList = service.retrieve()
        ///List with game words
        var gameWords: [Word] = []
        switch gameType {
        case "Practice the learned words":
            for questionWords in gameAllWordsList {
                if questionWords.isLearned ?? false {
                    gameWords.append(questionWords)
                }
            }
            gameWords.shuffle()
        case "Practice all words":
            for questionWords in gameAllWordsList {
                gameWords.append(questionWords)
            }
            gameWords.shuffle()
        default:
            break
        }
        
        return gameWords
    }
    
    func closePupUp() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setGradientBackground()
        
        let wordsList = getQuestionArray()
        createFirstQuestion(wordsList)
        
    }
}

extension QuizeGameVC {
    func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(backButton)
        view.addSubview(containerStack)
        
        containerStack.addArrangedSubview(questionStack)
        containerStack.addArrangedSubview(answersStack)
        
        questionStack.addArrangedSubview(progressLabel)
        questionStack.addArrangedSubview(progressView)
        questionStack.addArrangedSubview(questionLabel)
    }
    
    func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.left.equalTo(view).inset(20)
        }
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp_bottomMargin).offset(15)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view).inset(40)
        }
        progressLabel.snp.makeConstraints { make in
            make.left.equalTo(questionStack)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(questionStack).inset(50)
        }
    }
}

extension QuizeGameVC {
    
}

///Gradient Settings
extension QuizeGameVC {
    func setGradientBackground() {
        let colorTop =  UIColor.leftAppBackgroundColor.cgColor
        let colorBottom = UIColor.rightAppBackgroundColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setGreenGradientOnAnswerButton(_ sender: UIButton!) {
        let colorTop =  UIColor.correctAnswerLeftColor.cgColor
        let colorBottom = UIColor.correctAnswerRightColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.4, 1.0]
        gradientLayer.cornerRadius = 15
        gradientLayer.frame = sender.bounds
        
        sender.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setRedGradientOnAnswerButton(_ sender: UIButton!) {
        let colorTop =  UIColor.incorrectAnswerLeftColor.cgColor
        let colorBottom = UIColor.incorrectAnswerRightColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.1, 0.8]
        gradientLayer.cornerRadius = 15
        gradientLayer.frame = sender.bounds
        
        sender.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func removeGradientOnButtons() {
        for buttonIndex in 0..<4 {
            guard let gradientLayer = answerButtons[buttonIndex].layer.sublayers else { return }
            if gradientLayer.count > 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    gradientLayer[0].removeFromSuperlayer()
                })
            }
        }
    }
    
}


