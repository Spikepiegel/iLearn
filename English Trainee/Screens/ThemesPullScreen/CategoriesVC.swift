//
//  CategoriesVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 17.02.2023.
//

import UIKit
import SnapKit

//MARK: VC with all categories
final class CategoriesVC: UIViewController {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    var themesWasCreated = false

    lazy var categoriesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CategoriesCell.self, forCellReuseIdentifier: "CategoriesCell")
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupGradientVC()
        super.viewWillAppear(animated)
        categoriesTableView.reloadData()
    }
}

extension CategoriesVC {
    func setupViews() {
        view.addSubview(categoriesTableView)
        view.backgroundColor = .appBackgroundColor
        
    }
    
    func setupConstraints() {
        categoriesTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension CategoriesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        guard let header = view as? UITableViewHeaderFooterView else { return }

        header.textLabel?.frame = CGRect(x: header.bounds.origin.x,
                                         y: header.bounds.origin.y,
                                         width: 0,
                                         height: header.bounds.height)
        //header.textLabel?.textColor = .black
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
        return cell
    }
    
    
    
}

extension CategoriesVC: UITableViewDataSource {
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

///Gradient Settings
extension CategoriesVC {
    
    func setupGradientVC() {
        let gradientLayer = CAGradientLayer()
        
        guard let gradientSubLayer = view.layer.sublayers else { return }
        if gradientSubLayer.count > 1 {
            gradientSubLayer[0].removeFromSuperlayer()
        }
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            

            let colorTop =  UIColor.leftAppBackgroundColor.cgColor
            let colorBottom = UIColor.rightAppBackgroundColor.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
            
        case "Classic Black":
            let colorTop =  UIColor.black.cgColor
            let colorBottom = UIColor.black.cgColor
            
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = self.view.bounds
            
            self.view.layer.insertSublayer(gradientLayer, at:0)
            
 
            
        case "Classic White":
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
