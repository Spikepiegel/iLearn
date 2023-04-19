//
//  SettingsTableView.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 11.04.2023.
//

import UIKit
import Firebase

class SettingsTableView: UITableView {
    
    var onOpenRegisterPopUp: (() -> ())?
    var onSignOutPopUp: (() -> ())?
    var onDeleteAccount: (() -> ())?
    var onLogInPopUp: (() -> ())?
    var onAppThemeSelection: (() -> ())?
    var onAppVoiceSelection: (() -> ())?
    
    lazy var themeArchiever = ThemeAppArchiever(key: "selectedTheme")

    let header = SettingsHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 40))

    let names = SectionsRowsNames()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .insetGrouped)
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingsTableView {
    func setupTable() {
        self.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero
        self.tableHeaderView = header
    }
}

extension SettingsTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
    #warning("Feedback поставить значение 3")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 3
        case 1:
            return 2
            #warning("Feedback")
//        case 2:
//            return 3
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
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
        #warning("Feedback")
//        case 2:
//            cell.rowTitleLabel.text = names.thirdSectionRowsName[indexPath.row]
//            cell.chevronImage.isHidden = true
        default:
            break
        }
        
        return cell
        
        
    }
}
extension SettingsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return names.nameSection[section]  //nameSection[section]
    }
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){

        let header = view as! UITableViewHeaderFooterView
        
        switch themeArchiever.retrieve() {
        case "Blue Skies":
            header.textLabel?.textColor = UIColor.black
            
        case "Classic Black":
            header.textLabel?.textColor  = UIColor.white
            
        case "Classic White":
            header.textLabel?.textColor  = UIColor.black
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        
        ///Account Settings
        case 0:
            switch indexPath.row {
            ///Sign In Cell
            case 0:
                self.onOpenRegisterPopUp?()
            ///Log In Cell
            case 1:
                
                Auth.auth().addStateDidChangeListener { (auth, user) in
                    
                    if user != nil {
                        self.onSignOutPopUp?()
                    } else {
                        self.onLogInPopUp?()
                    }
                }
            ///Delete an acount cell
            case 2:
                self.onDeleteAccount?()
            default:
                break
            }
        ///App Settings Section
        case 1:
            switch indexPath.row {
            ///Change app theme cell
            case 0:
                self.onAppThemeSelection?()
            ///Change app voice cell
            case 1:
                self.onAppVoiceSelection?()
            default:
                break
            }
        ///Feedback section
        case 2:
            switch indexPath.row {
            case 0: break
            case 1:
                break
            case 2: break
            default:
                break
            }
        default:
            break
        }
    }
    
}
