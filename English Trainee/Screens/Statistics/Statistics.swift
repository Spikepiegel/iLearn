//
//  Statistics.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 07.03.2023.
//

import UIKit

class Statistics: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

    }

}

extension Statistics {
    func setupViews() {
        setupGradientVC()
        
    }
    
    func setupConstraints() {
        
    }
    ///Gradient Settings

}

extension Statistics {
    func setupGradientVC() {
        let colorTop =  UIColor.leftAppBackgroundColor.cgColor
        let colorBottom = UIColor.rightAppBackgroundColor.cgColor
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
