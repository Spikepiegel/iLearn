//
//  MainTabVC.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 13.02.2023.
//

import UIKit
import SnapKit

final class AppTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabBarSettings()
        
    }
    
    //MARK: TabBar Setup Settings
    private func setupTabBar() { //categories
        viewControllers = [
            setupVCs(viewController: GameVC(),
                     title: "Statistics",
                     image: UIImage(named: "statistics")),
            setupVCs(viewController: CategoriesVC(),
                     title: "All Categories",
                     image: UIImage(named: "categories")),
            setupVCs(viewController: UIViewController(),
                     title: "Settings",
                     image: UIImage(named: "gear"))
        ]
        UITabBar.appearance().barTintColor = .black
    }
    
    private func setupVCs(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    //MARK: TabBar UI Settings
    private func setupTabBarSettings() {
        
        let positionOnY: CGFloat = 14
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                          y: tabBar.bounds.minY,
                                                          width: tabBar.bounds.width,
                                                          height: height * 2),
                                      cornerRadius: 0)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = tabBar.bounds.width / 3
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.black.cgColor
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .unselectedItem
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animationWhenItemSelected(item)
    }
    
    //MARK: TabBar Animation Settings
    func animationWhenItemSelected(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity},
                                         delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
}

