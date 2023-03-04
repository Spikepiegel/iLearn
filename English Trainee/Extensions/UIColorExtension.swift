//
//  UIColorExtension.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 21.02.2023.
//

import UIKit

extension UIColor {
//    static var tabBarItemAccent: UIColor {
//        #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
//    }
//    static var mainWhite: UIColor {
//        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//    }
    
    //MARK: Color for TabBar elements
    static var unselectedItem: UIColor {
        #colorLiteral(red: 0.7733298966, green: 0.7733329849, blue: 0.7733329849, alpha: 1)
    }

    static var appBackgroundColor: UIColor {
        #colorLiteral(red: 0.937254902, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    }
    static var lightPurpleGradientColor: UIColor {
        #colorLiteral(red: 0.8249066213, green: 0.7117512407, blue: 1, alpha: 1)
    }
    
    
    //MARK: Colors for app backgorund gradient
    static var leftAppBackgroundColor: UIColor {
        #colorLiteral(red: 0.8549019608, green: 0.8862745098, blue: 0.9725490196, alpha: 1)
    }
    static var rightAppBackgroundColor: UIColor {
        #colorLiteral(red: 0.8399734204, green: 0.6431372549, blue: 0.6431372549, alpha: 1)
    }
    
    //MARK: Colors for Stack Views on the Game VC
    static var firstQuestionGameColor: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    static var secondQuestionGameColor: UIColor {
        #colorLiteral(red: 0.4274509804, green: 0.8352941176, blue: 0.9803921569, alpha: 1)
    }
    
    static var thirdQuestionGameColor: UIColor {
        #colorLiteral(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1)
    }
}
