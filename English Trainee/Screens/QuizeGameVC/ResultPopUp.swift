//
//  PopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 06.02.2023
//

import Foundation



import UIKit


class ResultPopUp: UIViewController {
    
    
    var delegate: QuizeGameVC?
    
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
        label.text = "Enter your account name"
        label.font = label.font.withSize(20)
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
        delegate?.closePupUp()
    }
    
    let defaultHeight: CGFloat = 300
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(popText)
        containerView.addSubview(closePopUpButton)
    }
    
    
    func setupConstraints() {
 
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        popText.translatesAutoresizingMaskIntoConstraints = false
        closePopUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                   constant: -containerView.bounds.height/2)
        ])
            
            
        NSLayoutConstraint.activate([
            popText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            popText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            
            closePopUpButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            closePopUpButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            closePopUpButton.topAnchor.constraint(equalTo: popText.bottomAnchor, constant: 20),
            closePopUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closePopUpButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)

            
        ])
        
    }
    
    
}
