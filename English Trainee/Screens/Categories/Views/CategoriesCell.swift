//
//  TableViewCell.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.02.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    
    var onCategorySelected: ((String)->())?
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    static let identifier = "CategoriesCell"

    var containerStack: UIStackView = {
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
    
    ///Parses JSON with and words categories and creates stackviews with buttons inside of one cell
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
    
    ///Method to create one StackView for buttons. It is used in createThemesOnView method
    func createHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }
    
    ///Creates button for one stackView. It is also used in createThemesOnView method
    func createStackButton(_ buttonText: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 12
        button.setImage(UIImage(named: buttonText), for: .normal)
        button.imageView?.snp.makeConstraints({ make in
            make.right.equalTo(button.titleLabel!.snp_leftMargin).inset(30)
        })
        button.setTitle(buttonText, for: .normal)
        button.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        button.addTarget(self, action: #selector(themeWasTapped) , for: .touchUpInside)
        
        return button
    }
    
    @objc func themeWasTapped(sender: UIButton!) {

        onCategorySelected?(sender.titleLabel?.text ?? "")
        
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

extension CategoriesCell {

    func setupGradientVC() {
                
        switch themeArchiever.retrieve()
        {
        case "Blue Skies":
            for verticalStack in containerStack.arrangedSubviews {
                for button in verticalStack.subviews {
                    let newButton = button as? UIButton
                    newButton?.backgroundColor = .white
                    newButton?.setTitleColor(.black, for: .normal)
                }
            }
        case "Classic Black":
            for verticalStack in containerStack.arrangedSubviews {
                for button in verticalStack.subviews {
                    let newButton = button as? UIButton
                    newButton?.backgroundColor = .darkCellTheme
                    newButton?.setTitleColor(.white, for: .normal)
                }
            }
        case "Classic White":
            for verticalStack in containerStack.arrangedSubviews {
                for button in verticalStack.subviews {
                    let newButton = button as? UIButton
                    newButton?.backgroundColor = .white
                    newButton?.setTitleColor(.black, for: .normal)
                }
            }
        default:
            break
        }
    }

}

