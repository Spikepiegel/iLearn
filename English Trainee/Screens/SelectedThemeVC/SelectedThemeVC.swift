//
//  SelectedThemeVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 23.02.2023.
//

import UIKit
import SnapKit

final class SelectedThemeVC: UIViewController {
    
    //easy cohesion
    var jsonService: JsonServiceProtocol?
    
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
    
    var wordsList = [WordInformation]()
    
    lazy var wordsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SelectedThemeCell.self, forCellReuseIdentifier: SelectedThemeCell.identifier)
        tableView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        let headerView = SelectedThemeView(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        tableView.tableHeaderView = headerView
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
        setupViews()
        setupConstraints()
        
        words = loadWords() //Array with words of selected Category
        }
    
    //MARK: Fetch Data from json with words of selected theme
    func loadWords() -> [WordInformation] {
        return jsonService?.loadJsonWords(filename: selectedTheme) ?? []
    }
}

extension SelectedThemeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension SelectedThemeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectedThemeCell.identifier, for: indexPath) as? SelectedThemeCell else {
            return UITableViewCell() }
        
        let word = words[indexPath.row]
        cell.update(word)
        return cell
    }

}

extension SelectedThemeVC {
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
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
            make.left.right.bottom.equalTo(view).inset(15)
        }
        
        
    }
    
}
