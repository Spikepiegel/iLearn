//
//  NewSettingsVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 11.04.2023.
//

import UIKit
import Firebase
import MessageUI

class SettingsVC: UIViewController {
    
    var settingsView: SettingsView { return self.view as! SettingsView }
    var header = SettingsHeader(frame: CGRect(x: 0, y: 0, width: 0, height: 40))

    override func loadView() {
        self.view = SettingsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openCellWindow()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingsView.setupGradientVC()
        settingsView.tableView.header.setupGradientVC()
        updateTableViewHeader()
        settingsView.tableView.reloadData()
    }
    
    func openCellWindow() {
        settingsView.tableView.onOpenRegisterPopUp = { [weak self] in
            let vc = ScreenFactory.makeRegisterPopUp()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onSignOutPopUp = { [weak self] in
            let vc = ScreenFactory.makeSignOutPopUp()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onDeleteAccount = { [weak self] in
            let vc = ScreenFactory.makeDeleteAccountPopUp()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onLogInPopUp = { [weak self] in
            let vc = ScreenFactory.makeLoginInPopUp()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onAppThemeSelection = { [weak self] in
            let vc = ScreenFactory.makeThemeSelectionScreen()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onAppVoiceSelection = { [weak self] in
            let vc = ScreenFactory.makeVoiceSelectionScreen()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        settingsView.tableView.onRateTheApp = {
            let productURL = URL(string: "https://itunes.apple.com/app/id6447917283")!

            var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)
            components?.queryItems = [
              URLQueryItem(name: "action", value: "write-review")
            ]

            guard let writeReviewURL = components?.url else {
              return
            }

            UIApplication.shared.open(writeReviewURL)
        }
        
        settingsView.tableView.onSendEmail = { [weak self] in
            if MFMailComposeViewController.canSendMail() {
                let composer = MFMailComposeViewController()
                composer.mailComposeDelegate = self
                composer.setToRecipients(["dev.nikolay.sidorov@yandex.ru"])
                composer.setSubject("Предложение")
                composer.setMessageBody("Добрый день, ...", isHTML: false)
                
                self?.present(composer, animated: true)
            }
            
        }
        
        settingsView.tableView.onShareTheApp = { [weak self] in
            let productURL = URL(string: "https://itunes.apple.com/app/id6447917283")!
            let activityViewController = UIActivityViewController(activityItems: [productURL],
                                                                  applicationActivities: nil)

            self?.present(activityViewController, animated: true, completion: nil)
        }
        
        
    }
   

    func updateTableViewHeader() {
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            
            if user != nil {
                let ref = Database.database().reference()
                
                let uid = (Auth.auth().currentUser?.uid)!
                
                ref.child("users/\(uid)/username").getData(completion:  { error, snapshot in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    let userName = snapshot?.value as? String ?? "Unknown";
                    //self?.header.usernameLabel.text = "Hello, \(userName)"
                    self?.settingsView.tableView.header.usernameLabel.text = "Hello, \(userName)"
                });
            } else {
                self?.settingsView.tableView.header.usernameLabel.text = "Log In"
            }
        }
        
    }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            switch result {
            case .sent:
                print("Email sent")
            case .saved:
                print("Draft saved")
            case .cancelled:
                print("Email cancelled")
            case  .failed:
                print("Email failed")
            @unknown default:
                break
            }
            controller.dismiss(animated: true, completion: nil)
        }
}
