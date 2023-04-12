//
//  AppThemeSelectionCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 16.03.2023.
//

import UIKit
import SnapKit

class AppThemeSelectionCell: UITableViewCell {
    
    static var identifier = "AppThemeSelectionCell"
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    lazy var themeNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var selectedAppThemeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.isHidden = true
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
    
    func updateThemeName(_ themeName: String) {
        themeNameLabel.text = themeName
    }
    
}

extension AppThemeSelectionCell {
    
    func setupViews() {
        selectionStyle = .none
        contentView.addSubview(themeNameLabel)
        contentView.addSubview(selectedAppThemeImage)
    }
    
    func setupConstraints() {
        themeNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(10)
        }
        
        selectedAppThemeImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(15)
        }

    }
    
}

extension AppThemeSelectionCell {
    func setupGradientVC() {
        
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            contentView.backgroundColor = .white
            themeNameLabel.textColor = .black
            selectedAppThemeImage.tintColor = .black
        case "Classic Black":
            contentView.backgroundColor = .darkCellTheme
            themeNameLabel.textColor = .white
            selectedAppThemeImage.tintColor = .white
        case "Classic White":
            contentView.backgroundColor = .white
            themeNameLabel.textColor = .black
            selectedAppThemeImage.tintColor = .black
        default:
            break
        }
    }

}
