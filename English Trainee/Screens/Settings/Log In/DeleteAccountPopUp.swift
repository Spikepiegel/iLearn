//
//  DeleteAccountPopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 18.04.2023.
//

import Foundation
import Firebase
import UIKit

class DeleteAccountPopUp: UIViewController {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    let menu = SettingsVC()

    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    lazy var popUpTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Delete your account?"
        label.font = label.font.withSize(20)
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closePopUp"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        button.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        return button
    }()
    
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Yes", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        return button
    }()
    
    
    @objc func closePopUp(){
        dismiss(animated: false, completion: nil)
    }
    
    @objc func deleteAccount() {
        
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupGradientVC()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(closeButton)
        containerView.addSubview(popUpTitleLabel)
        containerView.addSubview(enterButton)
    }
    
    
    func setupConstraints() {
        
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.height.equalTo(120)
            make.center.equalTo(view)
        }
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(popUpTitleLabel)
            make.right.equalTo(containerView).inset(10)
        }
        
        popUpTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(15)
            make.centerX.equalTo(containerView)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(popUpTitleLabel.snp_bottomMargin).offset(30)
            make.left.right.equalTo(containerView).inset(30)
            make.centerX.equalTo(containerView)
        }
        
    }
    
    
}

extension DeleteAccountPopUp {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            
            popUpTitleLabel.textColor = .black
            closeButton.tintColor = .black
            containerView.backgroundColor = .white
            enterButton.backgroundColor = .lightGray
            
        case "Classic Black":
            
            popUpTitleLabel.textColor = .lightGray
            closeButton.tintColor = .white
            containerView.backgroundColor = .darkCellTheme
            enterButton.backgroundColor = .lightGray
            
        case "Classic White":
            
            popUpTitleLabel.textColor = .black
            closeButton.tintColor = .black
            containerView.backgroundColor = .white
            enterButton.backgroundColor = .lightGray
            
        default:
            break
        }
    }
    
}
