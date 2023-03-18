//
//  SettingsVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 15.03.2023.
//

import UIKit
import UIKit

class MenuVC: UIViewController {
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")
    
    let names = SectionsRowsNames()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupGradientVC()
        settingsTable.reloadData()
    }
    
    lazy var settingsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(MenuCell.self, forCellReuseIdentifier: MenuCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.separatorInset = .zero
        return table
    }()
    
    
}

extension MenuVC {
    
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(settingsTable)
        settingsTable.layer.cornerRadius = 15
        
    }
    
    func setupConstraints() {
        settingsTable.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
    }
    
}

extension MenuVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return names.nameSection[section]  //nameSection[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            header.textLabel?.textColor = UIColor.black
            
        case "Classic Black":
            header.textLabel?.textColor = UIColor.whiteTheme
            
        case "Classic White":
            header.textLabel?.textColor = UIColor.black
        default:
            break
        }
    }
}

extension MenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 3 
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else {
            return UITableViewCell()
        }
        cell.setupGradientVC()
        
        switch indexPath.section {
        case 0:
            cell.rowTitleLabel.text = names.firstSectionRowsName[indexPath.row]
            cell.chevronImage.isHidden = true
        case 1:
            cell.rowTitleLabel.text = names.sectondSectionRowsName[indexPath.row]
            cell.chevronImage.isHidden = false
        case 2:
            cell.rowTitleLabel.text = names.thirdSectionRowsName[indexPath.row]
            cell.chevronImage.isHidden = true
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section {
            
        case 0:
            switch indexPath.row {
            case 0: break

                
            default:
                break
            }
            
        case 1:
            switch indexPath.row {
            case 0:
                let vc = AppThemeSelectionVC()
                vc.modalPresentationStyle = .fullScreen
                //vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            case 1:
                let vc = AppVoiceSelectionVC()
                vc.modalPresentationStyle = .fullScreen
                //vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            default:
                break
            }
            
        case 2: break
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}

extension MenuVC {
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
