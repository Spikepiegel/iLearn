//
//  SelectedThemeCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 24.02.2023.
//

import UIKit
import SnapKit

final class SelectedThemeCell: UITableViewCell {

    static let identifier = "SelectedThemeCell"
    
    lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "123"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
 
    }
    
    func update(_ word: WordInformation) {
        wordLabel.text = word.origin
    }
}

extension SelectedThemeCell {
    func setupViews() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.backgroundColor = .appBackgroundColor
        contentView.layer.cornerRadius = 10
        backgroundColor = .white
        selectionStyle = .none

        contentView.addSubview(wordLabel)
    }
    
    func setupConstraints() {

        
        wordLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(30)
            make.left.equalTo(contentView).inset(40)
        }
    }
}
