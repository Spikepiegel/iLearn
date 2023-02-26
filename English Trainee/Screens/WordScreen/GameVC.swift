//
//  GameViewController.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 05.02.2023.
//

import UIKit


final class GameVC: UIViewController {
    
    var questions = QuestionService().questions
    var calculateQuestion = QuestionService()
    var questionNumber = 0
    var progressLabelCounter = 1
    var buttonArray: [UIButton] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        createFirstQuestion()
        

    }
    
    lazy var containerStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    lazy var questionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15

        return stackView
    }()
    
    lazy var answersStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 15
        
        return stackView
    }()

    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.center = view.center
        progressView.setProgress(0, animated: false)
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .blue
        return progressView
    }()
    
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.textAlignment = .center
        label.text = "\(calculateQuestion.questionNumber)/\(questions.count)"
        
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    

    
    func updateQuestion() {
        questionNumber += 1
        
        let question = questions[questionNumber]
        questionLabel.text = question.word

        let answers = question.answers
        for index in 0..<answers.count {
            let answer = answers[index]
            buttonArray[index].setTitle(answer.text, for: .normal)
        }
        
    }
    
    func createFirstQuestion() {
        questionStack.addArrangedSubview(questionLabel)
        let question = questions[questionNumber]
        questionLabel.text = question.word
        
        let answers = question.answers
        for index in 0..<answers.count {
            let answer = answers[index]
            let button = createAnswersButtons()
            button.setTitle(answer.text, for: .normal)
            buttonArray.append(button)
            answersStack.addArrangedSubview(button)
            
        }
        
    }
    
    func createAnswersButtons() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        let question = QuestionService()
        
        let isCorrect = question.getAnswer(sender.currentTitle!, questionNumber)
        
        if isCorrect {
            sender.backgroundColor = UIColor.green
            calculateQuestion.getScore()
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        if calculateQuestion.questionNumber != questions.count {
            updateQuestion()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                sender.backgroundColor = UIColor.white
            })
            
            progressBar.progress += 0.2
            calculateQuestion.getQuestionNumber()

            progressLabel.text = "\(calculateQuestion.questionNumber)/\(questions.count)"
            
        } else {
            calculateQuestion.getQuestionNumber()
            progressBar.progress += 0.2

        }
        
        if calculateQuestion.questionNumber == questions.count + 1 {
            let vc = CustomModalViewController()
            vc.popText.text = "\(calculateQuestion.score)/\(questions.count) правильных ответов"
            vc.modalPresentationStyle = .overCurrentContext 
            self.present(vc, animated: false)
        }
    }

}


extension GameVC {
    
    func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        view.addSubview(containerStack)
        containerStack.addArrangedSubview(questionStack)
        containerStack.addArrangedSubview(answersStack)
        questionStack.addArrangedSubview(progressLabel)
        questionStack.addArrangedSubview(progressBar)
        questionStack.addArrangedSubview(questionLabel)
        
    }
    
    func setupConstraints() {
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),


        ])
    }
}
