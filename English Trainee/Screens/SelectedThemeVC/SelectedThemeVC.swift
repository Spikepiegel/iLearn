//
//  SelectedThemeVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 23.02.2023.
//

import UIKit
import SnapKit

protocol MyDelegate {
    func openVC()
}

class SelectedThemeVC: UIViewController, MyDelegate {
    
    func openVC() {
        let vc = WordsGameVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    //easy cohesion
    var jsonService: JsonServiceProtocol?
    var header = SelectedThemeHeader()
    
    var words = [WordInformation]()
    
    //MARK: selectedTheme - accept the name of theme which user has selected
    var selectedTheme: String
    
    init(selectedTheme: String) {
        self.selectedTheme = selectedTheme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            setupGradientVC()
            super.viewWillAppear(animated)
    }
    
    var wordsList = [WordInformation]()
    
    lazy var wordsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SelectedThemeCell.self, forCellReuseIdentifier: SelectedThemeCell.identifier)
        tableView.backgroundColor = .clear
        let headerView = SelectedThemeHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 310))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        headerView.themeLabel.text = selectedTheme
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func closeButtonPressed(sender: UIButton!) {
            dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = SelectedThemeHeader()
        vc.updateTheme(theme: selectedTheme)
        setupViews()
        setupConstraints()

        words = loadWords() //Array with words of selected Category
        header.themeLabel.text = selectedTheme
        }
    
    //MARK: Fetch Data from json with words of selected theme
    func loadWords() -> [WordInformation] {
        return jsonService?.loadJsonWords(filename: selectedTheme) ?? []
    }
    
}

extension SelectedThemeVC {
    
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(backButton)
        view.addSubview(wordsTable)
    }

    func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view).inset(50)
            make.left.equalTo(view).inset(20)
        }

        wordsTable.snp.makeConstraints { make in
            make.top.equalTo(backButton).inset(40)
            make.left.right.bottom.equalTo(view)//.inset(15)
        }
    }
    
}

extension SelectedThemeVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedThemeCell.identifier, for: indexPath) as? SelectedThemeCell else {
            return UITableViewCell() }
  
        let word = words[indexPath.row]
        cell.update(word)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .destructive, title: "") { (action, view, complete) in
            let cell = tableView.cellForRow(at: indexPath) as! SelectedThemeCell
            cell.learnedWordImage.isHidden.toggle()
         
            complete(true)
            }
            done.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
            done.image = UIImage(named: "done")
            let configuration = UISwipeActionsConfiguration(actions: [done])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration

    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let showTranslation = UIContextualAction(style: .normal, title: "") { (action, view, complete) in
//            let cell = tableView.cellForRow(at: indexPath) as! SelectedThemeCell
//            cell.wordTranslationLabel.isHidden.toggle()
//            complete(true)
//            }
//            showTranslation.image = UIImage(named: "showTranslation")
//            showTranslation.backgroundColor = .clear
//            let configuration = UISwipeActionsConfiguration(actions: [showTranslation])
//            configuration.performsFirstActionWithFullSwipe = false
//            return configuration
//
//    }
    
}

extension SelectedThemeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}

//MARK: Gradient Settings
extension SelectedThemeVC {
    func setupGradientVC() {
        let colorTop =  UIColor.leftAppBackgroundColor.cgColor
        let colorBottom = UIColor.rightAppBackgroundColor.cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.2, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
