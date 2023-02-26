//
//  ThemesTableViewCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 12.02.2023.
//

import UIKit
import SnapKit

final class ThemeCell: UITableViewCell {

    static let identifier = "WordsCell"
    
    private var containerStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}

extension ThemeCell {
    private func setupViews() {
        contentView.addSubview(containerStack)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalTo(contentView).inset(0)
            //make.edges.equalTo(contentView)
        }
    }
}
