//
//  RegisterPopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.03.2023.
//

import Foundation
import UIKit
import Firebase

class RegisterInPopUp: UIViewController {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    let menu = SettingsVC()

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
        label.text = "Sign In"
        label.font = label.font.withSize(20)
        return label
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Incorrect email/password"
        label.textColor = .red
        label.alpha = 0
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
    
    lazy var usernameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Username"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return text
    }()
    
    lazy var emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return text
    }()
    
    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButton), for: .touchUpInside)
        return button
    }()
    
    func displayWarningLabel(withText text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
            
        }
    }
    
    @objc func registerButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text,
              email != "",
              password != "",
              username != "",
              email.contains("@") else {
            displayWarningLabel(withText: "Email or password is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            
            if error == nil {
                if user != nil {
                    let uid = (Auth.auth().currentUser?.uid)!
                    let ref = Database.database().reference(withPath: "users").child(uid)
                    ref.setValue(["uid": uid,
                                  "email": email,
                                  "username": username,
                                  "creationDate": String(describing: Date())])
                    self?.updateHeaderAfterRegistration()


                    self?.dismiss(animated: false, completion: nil) // тут когда всё ок
                    
                }
            } else {
                self?.displayWarningLabel(withText: "This email/password is unavailable")
            }
            
        })
    }
    
    func updateHeaderAfterRegistration() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.menu.updateTableViewHeader()
        })
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
        containerView.addSubview(warningLabel)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(enterButton)
    }
    
    
    func setupConstraints() {
        
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.height.equalTo(280)
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
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(popUpTitleLabel.snp_bottomMargin).offset(20)
            make.centerX.equalTo(containerView)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(40)
            make.centerX.equalTo(containerView)
        }
    }
    
    
}

extension RegisterInPopUp {
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
