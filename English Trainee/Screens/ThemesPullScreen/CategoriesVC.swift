//
//  CategoriesVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 17.02.2023.
//

import UIKit
import SnapKit

final class CategoriesVC: UIViewController {

    
    lazy var tableCategories: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: "CategoriesCell")
        tableView.backgroundColor = .appBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
            }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
}

extension CategoriesVC {
    func setupViews() {
        view.addSubview(tableCategories)
        view.backgroundColor = .appBackgroundColor

    }
    
    func setupConstraints() {
        tableCategories.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension CategoriesVC: UITableViewDelegate {
    
}

extension CategoriesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.identifier, for: indexPath) as? CategoriesCell else {
            return UITableViewCell()
        }
        
        cell.createThemesOnView()
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        //
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = "All Categories"
        header.textLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
    
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Categories"
    }
}
