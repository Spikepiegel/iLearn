//
//  AppThemeSelectionVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 15.03.2023.
//

import UIKit
import SnapKit
import AVFoundation

class AppVoiceSelectionVC: UIViewController {
    
    let themes = AppThemesNames().themes
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    var voices = [Voice]()
    
    let synthesizer = AVSpeechSynthesizer()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func closeButtonPressed(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var themeSelectionTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AppVoiceSelectionCell.self, forCellReuseIdentifier: AppVoiceSelectionCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        loadVoices()

    }
    override func viewWillAppear(_ animated: Bool) {
        setupGradientVC()
    }
    
    func loadVoices() {
        voices = VoiceJsonService().loadRandomJsonWords(filename: "voices") ?? []
    }

}

extension AppVoiceSelectionVC {
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(backButton)
        view.addSubview(themeSelectionTable)
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.left.equalTo(view).inset(20)
        }
        themeSelectionTable.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp_bottomMargin).offset(10)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        
    }
}

extension AppVoiceSelectionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppVoiceSelectionCell.identifier, for: indexPath) as? AppVoiceSelectionCell else { return UITableViewCell() }
        
        cell.updateVoiceName(voices[indexPath.row].voiceName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utterance = AVSpeechUtterance(string: "Hello, I am \(voices[indexPath.row].voiceName)")
        utterance.voice = AVSpeechSynthesisVoice(identifier: voices[indexPath.row].voiceIdentifier)
        
        synthesizer.speak(utterance)
        
        let voiceArchiever = VoiceAppArchiever(key: "appVoice")
        voiceArchiever.save(voices[indexPath.row].voiceIdentifier)
    }
    
    
}

extension AppVoiceSelectionVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

extension AppVoiceSelectionVC {
    func setupGradientVC() {
        
        let gradientLayer = CAGradientLayer()
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            
            backButton.tintColor = .black
            
            let colorTop =  UIColor.leftAppBackgroundColor.cgColor
            let colorBottom = UIColor.rightAppBackgroundColor.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
            
        case "Classic Black":
            
            backButton.tintColor = .lightGray
            
            let colorTop =  UIColor.black.cgColor
            let colorBottom = UIColor.black.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
            
        case "Classic White":
            
            backButton.tintColor = .black
            
            let colorTop =  UIColor.whiteTheme.cgColor
            let colorBottom = UIColor.whiteTheme.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
        default:
            break
        }
    }

}
