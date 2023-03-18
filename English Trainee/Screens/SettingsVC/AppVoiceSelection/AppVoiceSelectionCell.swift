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

    lazy var voiceName: UILabel = {
        let label = UILabel()
        return label
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
    
    func updateVoiceName(_ name: String) {
        voiceName.text = name
    }
    
}

extension AppVoiceSelectionCell {
    func setupViews() {
        contentView.addSubview(voiceName)
        selectionStyle = .none
    }
    
    func setupConstraints() {
        voiceName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(10)
        }
    }
}

extension AppVoiceSelectionCell {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            contentView.backgroundColor = .white
            voiceName.textColor = .black
        case "Classic Black":
            contentView.backgroundColor = .darkCellTheme
            voiceName.textColor = .white
        case "Classic White":
            contentView.backgroundColor = .white
            voiceName.textColor = .black
        default:
            break
        }
    }

}
