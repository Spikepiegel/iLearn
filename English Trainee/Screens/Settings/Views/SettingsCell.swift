//
//  MenuCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 15.03.2023.
//

import UIKit
import SnapKit

class SettingsCell: UITableViewCell {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    static var identifier = "MenuCell"
    
    lazy var rowTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "123"
        return label
    }()
    
    lazy var chevronImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
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
    
    func setupViews() {
        contentView.addSubview(rowTitleLabel)
        contentView.addSubview(chevronImage)
        selectionStyle = .none
    }
    
    func setupConstraints() {
        rowTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(15)
        }
        chevronImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(15)
        }
    }
    
}

extension SettingsCell {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            contentView.backgroundColor = .white
            rowTitleLabel.textColor = .black
            chevronImage.tintColor = .black
        case "Classic Black":
            contentView.backgroundColor = .darkCellTheme
            rowTitleLabel.textColor = .white
            chevronImage.tintColor = .white
        case "Classic White":
            contentView.backgroundColor = .white
            rowTitleLabel.textColor = .black
            chevronImage.tintColor = .black
        default:
            break
        }
    }

}
