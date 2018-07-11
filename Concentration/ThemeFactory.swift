//
//  ThemeFactory.swift
//  Concentration
//
//  Created by Pablo Leite on 01/07/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

struct ThemeFactory {
    
    private static var themesDictionary = [
        "Halloween" : ["🎃", "👻", "😼", "⛄️", "🐼", "🦊"], //Initial Theme
        "Animals" : ["🐶", "🐱", "🐹", "🐰", "🦊", "🐼"], // Animals
        "Sports" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"], // Sports
        "Fruits" : ["🍓", "🍒", "🍑", "🥝", "🍇", "🍋"]  // Fruits
    ]
    
    static func theme(named themeName: String) -> [String]? {
        return themesDictionary[themeName]
    }
    
    static func randomTheme() -> [String] {
        let themes = Array(themesDictionary.values)
        return themes[Int.random(themes.count)]
    }
}
