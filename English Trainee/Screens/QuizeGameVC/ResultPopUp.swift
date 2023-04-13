//
//  PopUp.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 06.02.2023
//

import Foundation
import SnapKit
import UIKit


class ResultPopUp: UIViewController {
    
    
    weak var delegate: QuizeGameVC?
    
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
  
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(40)
            make.centerY.equalTo(view)
        }
        
        popText.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView).inset(20)
        }
        
        closePopUpButton.snp.makeConstraints { make in
            make.top.equalTo(popText.snp_bottomMargin).offset(20)
            make.left.right.equalTo(containerView).inset(40)
            make.bottom.equalTo(containerView).inset(20)
            make.centerX.equalTo(containerView)
        }
        
    }
    
    
}
