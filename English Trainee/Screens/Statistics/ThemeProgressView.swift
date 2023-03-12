//
//  ThemeProgressView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 10.03.2023.
//

import MultiProgressView
import UIKit
import SnapKit

class ThemeProgressView: MultiProgressView {
    
    private var themeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(themeLabel)
        themeLabel.snp.makeConstraints { make in
            make.left.equalTo(self).inset(8)
            make.centerY.equalTo(self)
        }
        
        addSubview(percentageLabel)
        percentageLabel.snp.makeConstraints { make in
            make.right.equalTo(self).inset(8)
            make.centerY.equalTo(self)
        }
    }
    
    func setupViews(_ themeName: String, _ themeProgress: Float) {
        themeLabel.text = themeName
        percentageLabel.text = "\(Int(themeProgress)) %"
        lineCap = .round
        cornerRadius = 6
    }
}
