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
    
    private func setupTabBar() {
        viewControllers = [
            setupVCs(viewController: GameVC(),
                     title: "Words",
                     image: UIImage(systemName: "magazine.fill")),
            setupVCs(viewController: CategoriesVC(),
                     title: "All Categories",
                     image: UIImage(systemName: "rectangle.stack.badge.person.crop.fill"))
        ]
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    }
    
    private func setupVCs(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
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
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animationWhenItemSelected(item)
    }
    
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

