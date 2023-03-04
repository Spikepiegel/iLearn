//
//  ViewController.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.03.2023.
//

import UIKit
import SnapKit

class WordsGameVC: UIViewController  {

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
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    lazy var questionBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    lazy var answersStack : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .white

        return stackView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Back", for: .normal)
        button.setImage(UIImage(named: "done"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func closeButtonPressed(sender: UIButton!) {
            dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setGradientBackground()
        setGradientAnswerStack()

    }

}



extension WordsGameVC {
    func setupViews() {
        view.backgroundColor = .clear

        view.addSubview(backButton)
        view.addSubview(containerStack)
        containerStack.addArrangedSubview(questionStack)
        containerStack.addArrangedSubview(answersStack)
        view.addSubview(questionBackgroundView)

    }

    func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.left.equalTo(view).inset(20)
        }
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(view).inset(100)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view).inset(40)
        }
        questionBackgroundView.snp.makeConstraints { make in
            make.edges.equalTo(questionStack)
        }

    }
}

//MARK: Gradient Settings
extension WordsGameVC {
    func setGradientBackground() {
        let colorTop =  UIColor.leftAppBackgroundColor.cgColor
        let colorBottom = UIColor.rightAppBackgroundColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setGradientAnswerStack() {
        let colorFirst =  UIColor.firstQuestionGameColor.cgColor
        let colorSecond = UIColor.secondQuestionGameColor.cgColor
        let colorThird = UIColor.thirdQuestionGameColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorFirst, colorSecond, colorThird]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.2, 0.7, 1.0]
        gradientLayer.frame = view.bounds
                
        questionBackgroundView.layer.insertSublayer(gradientLayer, at:0)
    }
}


