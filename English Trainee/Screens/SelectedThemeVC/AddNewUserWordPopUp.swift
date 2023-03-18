//
//  AddNewUserWordPopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 12.03.2023.
//

import Foundation
import UIKit

class AddNewUserWordPopUp: UIViewController {
    
    var delegate: SelectedThemeVCProtocol?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        label.text = "New word"
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
    
    lazy var originWordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "English word"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return text
    }()
    
    lazy var translationWordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Translation"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return text
    }()
    
    lazy var transcriptionWordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Transcription"
        text.font = UIFont.systemFont(ofSize: 15)
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.whileEditing
        text.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return text
    }()
    
    lazy var addWordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Add a new word", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addNewWordButton), for: .touchUpInside)
        return button
    }()
    
    @objc func addNewWordButton() {
        
        guard let originText = originWordTextField.text?.lowercased() else { return }
        guard let translationText = translationWordTextField.text?.lowercased() else { return }
        
        
        if !originText.isEmpty && !translationText.isEmpty && originText.count < 29 && translationText.count < 29 {
            self.delegate?.addNewWord(originText, translationText, transcriptionWordTextField.text)
            dismiss(animated: false, completion: nil)
        }
        
    }
    
    @objc func closePopUp(){
        
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(popUpTitleLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(originWordTextField)
        containerView.addSubview(translationWordTextField)
        containerView.addSubview(transcriptionWordTextField)
        containerView.addSubview(addWordButton)
    }
    
    
    func setupConstraints() {
 
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.top.bottom.equalTo(view).inset(330)
            make.center.equalTo(view)
        }
        popUpTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(15)
            make.centerX.equalTo(containerView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(popUpTitleLabel)
            make.right.equalTo(containerView).inset(10)
        }
        
        originWordTextField.snp.makeConstraints { make in
            make.top.equalTo(popUpTitleLabel.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        translationWordTextField.snp.makeConstraints { make in
            make.top.equalTo(originWordTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        
        transcriptionWordTextField.snp.makeConstraints { make in
            make.top.equalTo(translationWordTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(10)
        }
        
        addWordButton.snp.makeConstraints { make in
            make.top.equalTo(transcriptionWordTextField.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(40)
            make.centerX.equalTo(containerView)
        }
    }
    
    
}
