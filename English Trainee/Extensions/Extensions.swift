//
//  UIColorExtension.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 21.02.2023.
//

import UIKit

extension UIColor {
    
    ///Color for TabBar elements
    static var unselectedItem: UIColor {
        #colorLiteral(red: 0.7733298966, green: 0.7733329849, blue: 0.7733329849, alpha: 1)
    }
    
    static var appBackgroundColor: UIColor {
        #colorLiteral(red: 0.937254902, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    }
    static var lightPurpleGradientColor: UIColor {
        #colorLiteral(red: 0.8249066213, green: 0.7117512407, blue: 1, alpha: 1)
    }
    
    
    ///Colors for app backgorund gradient
    static var leftAppBackgroundColor: UIColor {
        #colorLiteral(red: 0.8549019608, green: 0.8862745098, blue: 0.9725490196, alpha: 1)
    }
    static var rightAppBackgroundColor: UIColor {
        #colorLiteral(red: 0.4274509804, green: 0.8352941176, blue: 0.9803921569, alpha: 1)
        // #colorLiteral(red: 0.8399734204, green: 0.6431372549, blue: 0.6431372549, alpha: 1)
    }
    
    ///Colors for Stack Views on the Game VC
    static var firstQuestionGameColor: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    static var secondQuestionGameColor: UIColor {
        #colorLiteral(red: 0.4274509804, green: 0.8352941176, blue: 0.9803921569, alpha: 1)
    }
    
    static var thirdQuestionGameColor: UIColor {
        #colorLiteral(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1)
    }
    
    ///Colors for Answer Buttons Gradient
    
    static var correctAnswerLeftColor: UIColor {
        #colorLiteral(red: 0.862745098, green: 0.8901960784, blue: 0.3568627451, alpha: 1)
    }
    static var correctAnswerRightColor: UIColor {
        #colorLiteral(red: 0.2705882353, green: 0.7137254902, blue: 0.2862745098, alpha: 1)
    }
    
    
    static var incorrectAnswerLeftColor: UIColor {
        #colorLiteral(red: 0.9294117647, green: 0.1294117647, blue: 0.2274509804, alpha: 1)
    }
    static var incorrectAnswerRightColor: UIColor {
        #colorLiteral(red: 0.5764705882, green: 0.1607843137, blue: 0.1176470588, alpha: 1)
    }
    
    ///Selected Theme Backround Color
    static var learnedWordsMarkLeftColor: UIColor {
        #colorLiteral(red: 0.6588235294, green: 1, blue: 0.4705882353, alpha: 1)
    }
    
    ///Selected Theme Backround Color
    static var learnedWordsMarkRightColor: UIColor {
        #colorLiteral(red: 0.4705882353, green: 1, blue: 0.8392156863, alpha: 1)
    }
    
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

extension UIImageView{
    func setImageAnimation(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}

//let defaults = UserDefaults.standard
//defaults.removeObject(forKey: "New Year")
//defaults.synchronize()
