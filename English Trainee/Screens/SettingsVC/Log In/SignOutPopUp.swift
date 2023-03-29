//
//  LogOutPopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.03.2023.
//


import Foundation
import UIKit
import Firebase

class SignOutPopUp: UIViewController {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    let menu = MenuVC()
    
    lazy var containerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .white
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
        label.text = "You have logged in already"
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
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Log Out", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutPressed() {
        do {
           try Auth.auth().signOut()
            menu.updateTableViewHeader()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: false, completion: nil)
    }
    
    @objc func closePopUp(){
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
        containerView.addSubview(logoutButton)
    }
    
    
    func setupConstraints() {
        
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.top.bottom.equalTo(view).inset(350)
            make.center.equalTo(view)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(5)
            make.right.equalTo(containerView).inset(10)
        }
        
        popUpTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp_bottomMargin).offset(20)
            make.centerX.equalTo(containerView)
        }
        
        logoutButton.snp.makeConstraints { make in
            //make.top.equalTo(popUpTitleLabel.snp_bottomMargin).offset(20)
            make.bottom.equalTo(containerView).inset(20)
            make.left.right.equalTo(containerView).inset(40)
            make.centerX.equalTo(containerView)
        }
    }
    
    
}

extension SignOutPopUp {
    func setupGradientVC() {
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            
            popUpTitleLabel.textColor = .black
            closeButton.tintColor = .black
            containerView.backgroundColor = .white
            logoutButton.backgroundColor = .lightGray
            
        case "Classic Black":
            
            popUpTitleLabel.textColor = .lightGray
            closeButton.tintColor = .white
            containerView.backgroundColor = .darkCellTheme
            logoutButton.backgroundColor = .lightGray
            
        case "Classic White":

            popUpTitleLabel.textColor = .black
            closeButton.tintColor = .black
            containerView.backgroundColor = .white
            logoutButton.backgroundColor = .lightGray
            
        default:
            break
        }
    }
    
}
