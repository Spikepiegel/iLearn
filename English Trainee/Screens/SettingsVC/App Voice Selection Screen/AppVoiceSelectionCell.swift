//
//  AppVoiceSelectionCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 18.03.2023.
//

import UIKit
import SnapKit

class AppVoiceSelectionCell: UITableViewCell {

    static var identifier = "AppVoiceSelectionCell"
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    lazy var voiceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var voiceLanguageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var selectedAppVoiceImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.isHidden = true
        return image
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupGradientVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateVoiceName(_ name: String, _ language: String) {
        voiceNameLabel.text = name
        voiceLanguageLabel.text = "(\(language))"
    }
    
}

extension AppVoiceSelectionCell {
    func setupViews() {
        contentView.addSubview(voiceNameLabel)
        contentView.addSubview(voiceLanguageLabel)
        contentView.addSubview(selectedAppVoiceImage)
        selectionStyle = .none
    }
    
    func setupConstraints() {
        voiceNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(10)
        }
        
        voiceLanguageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(voiceNameLabel.snp_rightMargin).offset(15)
        }
        
        selectedAppVoiceImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(15)
        }
    }
}

extension AppVoiceSelectionCell {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            contentView.backgroundColor = .white
            voiceNameLabel.textColor = .black
            voiceLanguageLabel.textColor = .black
            selectedAppVoiceImage.tintColor = .black
        case "Classic Black":
            contentView.backgroundColor = .darkCellTheme
            voiceNameLabel.textColor = .white
            voiceLanguageLabel.textColor = .white
            selectedAppVoiceImage.tintColor = .white
        case "Classic White":
            contentView.backgroundColor = .white
            voiceNameLabel.textColor = .black
            voiceLanguageLabel.textColor = .black
            selectedAppVoiceImage.tintColor = .black
        default:
            break
        }
    }

}
