//
//  CategoriesTableView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 19.03.2023.
//

import UIKit

class CategoriesTableView: UITableView {
    
    var onEvent: ((String)->())?
    
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    private var themesWasCreated = false

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        setupTable()
    }
    
    func setupTable() {
        self.register(CategoriesCell.self, forCellReuseIdentifier: "CategoriesCell")
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoriesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        guard let header = view as? UITableViewHeaderFooterView else { return }

        header.textLabel?.frame = CGRect(x: header.bounds.origin.x,
                                         y: header.bounds.origin.y,
                                         width: 0,
                                         height: header.bounds.height)
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            header.textLabel?.textColor = .black
        case "Classic Black":
            header.textLabel?.textColor = .white
        case "Classic White":
            header.textLabel?.textColor = .black

        default:
            break
        }
        header.textLabel?.text = "All Categories"
        header.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 40)

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categoriesHeader = "All Categories"
        return categoriesHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {
            return UITableViewCell()
        }
        
        if !themesWasCreated {
            themesWasCreated = true
            cell.createThemesOnView()
        }
        cell.backgroundColor = .clear
        cell.setupGradientVC()
        
        
        
        cell.onCategorySelected = { categoryName in
            self.onEvent?(categoryName)
        }
        
        return cell
    }
    
    
    
}

extension CategoriesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1500
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
