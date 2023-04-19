//
//  ScreenFactory.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 14.04.2023.
//

import Foundation


final class ScreenFactory {
    
    ///Method returns first screen with user's statistics
    static func makeStatisticsScreen() -> StatisticsVC {
        let vc = StatisticsVC.init()
        return vc
    }
    ///Method returns second screen with all categories
    static func makeCategoriesScreen() -> CategoriesVC {
        let vc = CategoriesVC.init()
        vc.service = JsonServiceImpl()
        return vc
    }
    
    ///Method returns creen with selected theme
    static func makeSelectedThemeScreen(name: String) -> SelectedThemeVC {
        let vc = SelectedThemeVC(selectedCategoryName: name)
        vc.jsonService = JsonServiceImpl()
        return vc
    }
    
    ///Method returns screen when user doesn't have the learned words
    static func makeNoLearnedWordsPopUp() -> NoLearnedWordsPopUp {
        let vc = NoLearnedWordsPopUp.init()
        return vc
    }
    
    ///Method returns PopUp with adding a new custom word in selected theme
    static func makeAddNewUserWordPopUp() -> AddNewUserWordPopUp {
        let vc = AddNewUserWordPopUp.init()
        return vc
    }
    
    ///Method returns screen with a quize game
    static func makeQuizeGameScreen(_ gameType: String, _ selectedCategoryName: String) -> QuizeGameVC {
        let vc = QuizeGameVC(gameType: gameType, selectedTheme: selectedCategoryName)
        return vc
    }
    
    ///Method returns third screen with settings
    static func makeSettingsScreen() -> SettingsVC {
        let vc = SettingsVC.init()
        return vc
    }
    
    static func makeLoginInPopUp() -> LogInPopUp {
        let vc = LogInPopUp.init()
        return vc
    }
    
    static func makeRegisterPopUp() -> RegisterInPopUp {
        let vc = RegisterInPopUp.init()
        return vc
    }
    
    static func makeSignOutPopUp() -> SignOutPopUp {
        let vc = SignOutPopUp.init()
        return vc
    }
    
    static func makeThemeSelectionScreen() -> AppThemeSelectionVC {
        let vc = AppThemeSelectionVC.init()
        return vc
    }
    
    static func makeVoiceSelectionScreen() -> AppVoiceSelectionVC {
        let vc = AppVoiceSelectionVC.init()
        return vc
    }
    
    static func makeDeleteAccountPopUp() -> DeleteAccountPopUp {
        let vc = DeleteAccountPopUp()
        return vc
    }
    
}
