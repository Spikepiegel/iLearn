//
//  StatisticsVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 10.03.2023.
//

import Foundation
import UIKit
import MultiProgressView

class StatisticsVC: UIViewController {
    
    var jsonService: JsonServiceProtocol?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        return scroll
    }()
    
    private lazy  var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 2000)
    }
    
    lazy var containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.backgroundColor = .clear
        return stack
    }()
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Categories"
        return label
    }()
    
    lazy var totalProgressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 15)
        label.textAlignment = .right
        label.textColor = .gray
       // label.text = "Total progress \(getTotalProgress()) %"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupGradientVC()
        createThemesProgressBars()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateProgressWhenScreenWasOpenedAgain()
        totalProgressLabel.text = "Total progress \(getTotalProgress()) %"
    }
    
    
    
}

extension StatisticsVC: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return 2
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        
        let sectionView = ProgressViewSection()
        
        switch section {
        case 0:
            sectionView.backgroundColor = .blue
        case 1:
            sectionView.backgroundColor = UIColor.barColor
        default:
            break
        }
        return sectionView
    }
    ///Method to animate progress of progress bar
    private func animateSetProgress(_ progressView: ThemeProgressView, firstProgress: Float, secondProgress: Float) {
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            progressView.setProgress(section: 0, to: firstProgress)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                progressView.setProgress(section: 1, to: secondProgress)
            }, completion: nil)
        }
    }
    
}

extension StatisticsVC {
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(categoriesLabel)
        contentView.addSubview(totalProgressLabel)
        contentView.addSubview(containerView)
        
    }
    
    func setupConstraints() {
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(140)
            make.left.equalTo(contentView).inset(20)
        }
        
        totalProgressLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(categoriesLabel)
            make.right.equalTo(contentView).inset(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp_bottomMargin).offset(15)
            make.left.right.equalTo(contentView).inset(20)
        }
    }
}

extension StatisticsVC {
    
    ///method with iteration to create all progress bars
    func createThemesProgressBars() {
        guard let service = JsonServiceImpl().loadJsonCategories(filename: "Themes") else { return }
        
        for themesStack in 0...service.count - 1 {
            
            for themeName in service[themesStack].themes {
                let progressBar = ThemeProgressView()
                progressBar.borderWidth = 1
                progressBar.borderColor = .black
                progressBar.backgroundColor = .white
                progressBar.dataSource = self
                progressBar.setupViews(themeName.name, "\(calculatePercentageProgress(themeName.name)) %")
                containerView.addArrangedSubview(progressBar)
                progressBar.snp.makeConstraints { make in
                    make.left.right.equalTo(containerView)
                    make.height.equalTo(30)
                }
                let additionalPercentage: Double = Double(calculatePercentageProgress(themeName.name) / 10)
                animateSetProgress(progressBar, firstProgress: 0, secondProgress: 0 + 0.02)
            }
        }
    }
    
    ///Calculates count of learned words
    func calculatePercentageProgress(_ themeName: String) -> Int {
        
        let wordsArchiver = WordsArchiver(key: themeName)
        //UserDefaults.standard.removeObject(forKey: themeName)
        
        var words = wordsArchiver.retrieve()
        if words.isEmpty {
            //wordsArchiver.save(jsonService?.loadJsonWords(filename: themeName) ?? [])
            words = JsonServiceImpl().loadJsonWords(filename: themeName) ?? []
        }
        var learnedWordsCounter = 0
        
        for wordsThemeList in words {
            if wordsThemeList.isLearned ?? false {
                learnedWordsCounter += 1
            }
        }
        
        
        return learnedWordsCounter * 100 / words.count
    }
    ///Method to animate bar every time when user opens this VC
    func updateProgressWhenScreenWasOpenedAgain() {
        let bars = self.containerView.arrangedSubviews.compactMap{ $0 as? ThemeProgressView }
        var numberOfBar = 0
        
        guard let service = JsonServiceImpl().loadJsonCategories(filename: "Themes") else { return }
        
        for themesStack in 0...service.count - 1 {
            
            for themeName in service[themesStack].themes {
                let additionalPercentage: Double = Double(calculatePercentageProgress(themeName.name) / 1)
                bars[numberOfBar].setProgress(section: 1, to: 0)
                animateSetProgress(bars[numberOfBar] , firstProgress: 0, secondProgress: 0.3)
                bars[numberOfBar].setupViews(themeName.name, "\(calculatePercentageProgress(themeName.name)) %")
                numberOfBar += 1
            }
        }
        
    }
    
    ///Method to get full progress
    func getTotalProgress() -> Int {
        var totalLearnedWords = 0
        var totalWords = 0
        guard let service = JsonServiceImpl().loadJsonCategories(filename: "Themes") else { return totalLearnedWords }

        for themesStack in 0...service.count - 1 {
            
            for themeName in service[themesStack].themes {
                let wordsArchiver = WordsArchiver(key: themeName.name)
                
                var words = wordsArchiver.retrieve()
                if words.isEmpty {
                    //wordsArchiver.save(jsonService?.loadJsonWords(filename: themeName.name) ?? [])
                    words = JsonServiceImpl().loadJsonWords(filename: themeName.name) ?? []
                }
                
                for wordsCategory in words {
                    if wordsCategory.isLearned ?? false {
                        totalLearnedWords += 1
                    }
                    totalWords += 1
                }
            }
        }
        print(totalLearnedWords * 100 / totalWords)
        return totalLearnedWords * 100 / totalWords
    }
    
    
}

extension StatisticsVC {
    
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
