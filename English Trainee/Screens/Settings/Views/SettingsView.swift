//
//  SettingsView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 11.04.2023.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    let tableView = SettingsTableView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        self.backgroundColor = .clear
        self.addSubview(tableView)
        tableView.layer.cornerRadius = 15
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

}


extension SettingsView {
    
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
