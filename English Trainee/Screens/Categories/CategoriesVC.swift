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

    var categoriesView: CategoriesView { return self.view as! CategoriesView }
    
    override func loadView() {
        self.view = CategoriesView(frame: UIScreen.main.bounds)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesView.tableView.onEvent = { categoryName in
            
            
            let service = JsonServiceImpl()
            let vc = SelectedThemeVC(selectedTheme: categoryName)
            vc.jsonService = service //Dependency Injection
    
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoriesView.update()
    }
}


