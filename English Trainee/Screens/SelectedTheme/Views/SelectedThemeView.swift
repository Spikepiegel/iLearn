//
//  NewSelectedThemeView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.04.2023.
//

import UIKit
import SnapKit

class SelectedThemeView: UIView {

    var wordsArchiver: WordsArchiver?
    

    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    var wordsTable = SelectedThemeTable.init()

    var onBackButonEvent: (()->Void)?
    var onShowHideTanslationEvent: (() -> Void)?
    var onAddWordEvent: (() -> Void)?

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonPressed(sender: UIButton!) {
        onBackButonEvent?()
    }
    
    lazy var showHideTranslationButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setImage(UIImage(named: "show"), for: .normal)
        

        
        button.addTarget(self, action: #selector(showHideAllWordsTranslation), for: .touchUpInside)
        return button
    }()
    
    @objc func showHideAllWordsTranslation(sender: UIButton!) {
        onShowHideTanslationEvent?()
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
        onAddWordEvent?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupGradientVC()

    }
    
    func getGameType() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passWordsToTable(_ wordsList: [Word], _ selectedCategoryName: String) {
        wordsTable.loadWordsList(wordsList, selectedCategoryName)
    }
    
}

extension SelectedThemeView {
    func setupViews() {
        self.backgroundColor = .clear
        self.addSubview(backButton)
        self.addSubview(addWordButton)
        self.addSubview(wordsTable)
        self.addSubview(showHideTranslationButton)

    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self).inset(50)
            make.left.equalTo(self).inset(20)
        }
        addWordButton.snp.makeConstraints { make in
            make.top.equalTo(self).inset(50)
            make.right.equalTo(self).inset(20)
        }
        wordsTable.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(55)
            make.left.right.bottom.equalTo(self)
        }
        
        showHideTranslationButton.snp.makeConstraints { make in
            make.top.equalTo(self).inset(50)
            make.right.equalTo(self).inset(75)
        }
    }
    
}

extension SelectedThemeView {
    func setupGradientVC() {
        let gradientLayer = CAGradientLayer()

//        guard let gradientSubLayer = self.layer.sublayers else { return }
//        if gradientSubLayer.count > 4 {
//            gradientSubLayer[0].removeFromSuperlayer()
//        }
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            

            let colorTop =  UIColor.leftAppBackgroundColor.cgColor
            let colorBottom = UIColor.rightAppBackgroundColor.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)
            backButton.tintColor = .black
            addWordButton.tintColor = .black
            showHideTranslationButton.tintColor = .black
            wordsTable.separatorColor = .black
            
        case "Classic Black":
            let colorTop =  UIColor.black.cgColor
            let colorBottom = UIColor.black.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)
            backButton.tintColor = .white
            addWordButton.tintColor = .white
            showHideTranslationButton.tintColor = .white

            wordsTable.separatorColor = .lightGray

        case "Classic White":
            let colorTop =  UIColor.whiteTheme.cgColor
            let colorBottom = UIColor.whiteTheme.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)

            backButton.tintColor = .black
            addWordButton.tintColor = .black
            showHideTranslationButton.tintColor = .black

            wordsTable.separatorColor = .black

        default:
            return
        }
    }
}
