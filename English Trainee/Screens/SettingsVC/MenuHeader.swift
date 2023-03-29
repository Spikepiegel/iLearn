//
//  MenuHeader.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.03.2023.
//

import UIKit
import SnapKit
import Firebase

class MenuHeader: UIView {

    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.alpha = 0.3

        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

extension MenuHeader {
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(usernameLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalTo(containerView).inset(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientVC()
    }
    
}

extension MenuHeader {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve()
        {
        case "Blue Skies":
            usernameLabel.textColor = .black
        case "Classic Black":
            usernameLabel.textColor = .white

        case "Classic White":
            usernameLabel.textColor = .black

        default:
            break
        }
    }
}
