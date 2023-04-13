//
//  CategoriesVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 17.02.2023.
//

import UIKit
import SnapKit

final class ScreenFactory {
    
    static func makeCategoriesScreen() -> CategoriesVC {
        
        //let jsonService = JsonServiceImpl()
        let vc = CategoriesVC.init()
        vc.service = JsonServiceImpl()
        return vc
    }
    
    static func makeSelectedThemeScreen(name: String) -> SelectedThemeVC {
        let vc = SelectedThemeVC(selectedCategoryName: name)
        vc.jsonService = JsonServiceImpl()
        return vc
    }
}

//MARK: VC with all categories
final class CategoriesVC: UIViewController {
        
    var service: JsonServiceProtocol?

    var categoriesView: CategoriesView { return self.view as! CategoriesView }
    
    override func loadView() {
        self.view = CategoriesView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    func setupTable() {
        categoriesView.tableView.onEvent = { [weak self] categoryName in
            
            let vc = ScreenFactory.makeSelectedThemeScreen(name: categoryName)
            
            //let vc = SelectedThemeVC(selectedCategoryName: categoryName)
            //vc.jsonService = self?.service //Dependency Injection
    
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoriesView.setupGradient()
    }
}


