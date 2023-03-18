//
//  SelectedThemeCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 24.02.2023.
//

import UIKit
import SnapKit
import AVFoundation


final class SelectedThemeCell: UITableViewCell {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    static let identifier = "SelectedThemeCell"
    var soundDelegate: SelectedThemeVCProtocol?
    ///Word in English
    lazy var wordOriginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hoefler Text", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    ///Transcription of the word
    lazy var wordTranscriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 18)
        return label
    }()
    ///Word in Russian
    lazy var wordTranslationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Hoefler Text", size: 20)
        return label
    }()
    
    ///Sound word button
    lazy var soundEnglishWordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sound"), for: .normal)
        button.addTarget(self, action: #selector(soundEnglishWord), for: .touchUpInside)
        return button
    }()

    @objc func soundEnglishWord(sender: UIButton!) {
        soundDelegate?.soundWord(wordOriginLabel.text!)
    }
    
    ///Icon which mark the cell with word, which user has learned
    lazy var learnedWordImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "unDone")!.withRenderingMode(.alwaysTemplate)
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    ///Updates cell information. Method is used in cellForRowAt method
    func update(_ word: Word) {
        wordOriginLabel.text = word.origin
        wordTranscriptionLabel.text = word.transcription
        
        if word.translationIsHShown == true {
            wordTranslationLabel.text = word.translation
        } else {
            wordTranslationLabel.text = nil
        }
    }
    
}

extension SelectedThemeCell {
    func setupViews() {
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(wordOriginLabel)
        contentView.addSubview(wordTranscriptionLabel)
        contentView.addSubview(wordTranslationLabel)
        contentView.addSubview(learnedWordImage)
        contentView.addSubview(soundEnglishWordButton)
    }
    
    func setupConstraints() {
        
        
        wordOriginLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.left.equalTo(contentView).inset(20)
            make.right.equalTo(contentView).inset(80)
        }
        wordTranscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(wordOriginLabel.snp_bottomMargin).offset(25)
            make.left.equalTo(contentView).inset(20)
            make.right.equalTo(contentView).inset(80)
        }
        wordTranslationLabel.snp.makeConstraints { make in
            make.top.equalTo(wordTranscriptionLabel.snp_bottomMargin).offset(20)
            make.left.equalTo(contentView).inset(20)
        }
        learnedWordImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.right.equalTo(contentView.snp_rightMargin).inset(5)
        }
        soundEnglishWordButton.snp.makeConstraints { make in
            make.top.equalTo(wordTranscriptionLabel.snp_topMargin)
            //make.left.equalTo(contentView.snp_rightMargin).inset(40)
            make.right.equalTo(contentView.snp_rightMargin).inset(5)
            make.bottom.equalTo(wordTranscriptionLabel.snp_bottomMargin)
        }
    }
}

extension SelectedThemeCell {
    func setupGradientVC() {
                
        switch themeArchiever.retrieve()
        {
        case "Blue Skies":
            wordOriginLabel.textColor = .black
            wordTranslationLabel.textColor = .black
            wordTranscriptionLabel.textColor = .black
            learnedWordImage.tintColor = .black
            soundEnglishWordButton.tintColor = .black
            contentView.backgroundColor = .white
        case "Classic Black":
            wordOriginLabel.textColor = .white
            wordTranslationLabel.textColor = .white
            wordTranscriptionLabel.textColor = .white
            learnedWordImage.tintColor = .white
            soundEnglishWordButton.tintColor = .white
            contentView.backgroundColor = .darkCellTheme
        case "Classic White":
            wordOriginLabel.textColor = .black
            wordTranslationLabel.textColor = .black
            wordTranscriptionLabel.textColor = .black
            learnedWordImage.tintColor = .black
            soundEnglishWordButton.tintColor = .black
            contentView.backgroundColor = .white
        default:
            break
        }
    }
}
