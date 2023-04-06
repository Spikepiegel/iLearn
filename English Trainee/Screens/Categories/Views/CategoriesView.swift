//
//  CategoriesView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 02.04.2023.
//

import Foundation
import UIKit

final class CategoriesView: UIView {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    var tableView = CategoriesTableView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGradient() {
        setupGradientVC()
        tableView.reloadData()
    }
    
}

extension CategoriesView {
    
    func setupViews() {
        self.addSubview(tableView)
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}

extension CategoriesView {
    
    func setupGradientVC() {
        let gradientLayer = CAGradientLayer()
        
        guard let gradientSubLayer = self.layer.sublayers else { return }
        if gradientSubLayer.count > 1 {
            gradientSubLayer[0].removeFromSuperlayer()
        }
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            

            let colorTop =  UIColor.leftAppBackgroundColor.cgColor
            let colorBottom = UIColor.rightAppBackgroundColor.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)
            
            
        case "Classic Black":
            let colorTop =  UIColor.black.cgColor
            let colorBottom = UIColor.black.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)
            
 
            
        case "Classic White":
            let colorTop =  UIColor.whiteTheme.cgColor
            let colorBottom = UIColor.whiteTheme.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.bounds
            
            self.layer.insertSublayer(gradientLayer, at:0)
            

                        
        default:
            break
        }
    }
}
