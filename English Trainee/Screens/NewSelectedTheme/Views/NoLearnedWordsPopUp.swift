//
//  NoLearnedWordsPopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 06.03.2023.
//


import Foundation
import UIKit
import SnapKit

class NoLearnedWordsPopUp: UIViewController {
    
        
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var popText: UILabel = { //popTextLabel, labelPopText
        let label = UILabel()
        label.text = """
        You don't have a list of the learned words yet
           Swipe the words to mark them as learned 📚
        """
        label.textAlignment = .center
        label.numberOfLines = 0
        //label.adjustsFontSizeToFitWidth = true
        label.font = label.font.withSize(16)
        return label
    }()
    
    lazy var closePopUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Okay!", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonPressed(sender: UIButton!) {
        dismiss(animated: false, completion: nil)
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupGradientVC()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(popText)
        containerView.addSubview(closePopUpButton)
    }
    
    
    func setupConstraints() {        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(25)
            make.height.equalTo(140)
            make.center.equalTo(view)
        }
        popText.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(20)
            make.centerX.equalTo(containerView)
        }
        closePopUpButton.snp.makeConstraints { make in
            make.top.equalTo(popText.snp_bottomMargin).offset(30)
            make.left.right.equalTo(containerView).inset(40)
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView).inset(20)
        }
    }
    
    
}

extension NoLearnedWordsPopUp {
    func setupGradientVC() {
        lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

        switch themeArchiever.retrieve() {
        case "Blue Skies":
            containerView.backgroundColor = .white
            popText.textColor = .black
        case "Classic Black":
            containerView.backgroundColor = .darkCellTheme
            popText.textColor = .white
        case "Classic White":
            containerView.backgroundColor = .darkCellTheme
            popText.textColor = .black

        default:
            break
        }
    }
}
