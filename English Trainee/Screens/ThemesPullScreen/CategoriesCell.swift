//
//  TableViewCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.02.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    
    static let identifier = "CategoriesCell"

    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.backgroundColor = .clear
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        contentView.backgroundColor = .clear
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createThemesOnView() {
        guard let service = JsonServiceImpl().loadJsonCategories(filename: "Themes") else { return }
        
        for themesStack in 0...service.count - 1 {
            let stack = createHorizontalStack()
            containerStack.addArrangedSubview(stack)
            
            for themeName in service[themesStack].themes {
                let button = createStackButton(themeName.name)
                stack.addArrangedSubview(button)
            }
        }
        
        
    }

    func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }
    
    func createStackButton(_ buttonText: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.6
        button.setImage(UIImage(named: buttonText), for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle(buttonText, for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(35)
        }
        button.addTarget(self, action: #selector(themeWasTapped) , for: .touchUpInside)

        return button
    }
    
    @objc func themeWasTapped(sender: UIButton!) {
        
        let service = JsonServiceImpl()
        let vc = SelectedThemeVC(selectedTheme: sender.titleLabel?.text ?? "")
        vc.jsonService = service //Dependency Injection
        
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true)
    }
    
}

extension CategoriesCell {
    func setupViews() {
        contentView.addSubview(containerStack)
        contentView.backgroundColor = .appBackgroundColor
        contentView.layer.borderWidth = 0
        selectionStyle = .none
    }
    
    func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.equalTo(contentView).inset(5)
            make.right.equalTo(contentView).inset(5)
        }
        
    }
}


