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
        
    var service: JsonServiceProtocol?

    var categoriesView: CategoriesView { return self.view as! CategoriesView }
    
    let photoAPI = NetworkDataFetcher()
    
    override func loadView() {
        self.view = CategoriesView(frame: UIScreen.main.bounds)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        photoAPI.fetchImages(searchTerm: "nature") { (results) in
            results?.results.map {(photo) in
                print(photo.urls.small)
            }
        }
    }
    
    
    func setupTable() {
        categoriesView.tableView.onEvent = { [weak self] categoryName in
            
            let vc = ScreenFactory.makeSelectedThemeScreen(name: categoryName)
    
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoriesView.setupGradient()
    }
}


