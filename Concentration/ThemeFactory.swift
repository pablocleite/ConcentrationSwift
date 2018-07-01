//
//  ThemeFactory.swift
//  Concentration
//
//  Created by Pablo Leite on 01/07/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

struct ThemeFactory {
    
    private static var themes = [
        ["🎃", "👻", "😼", "⛄️", "🐼", "🦊"], //Initial Theme
        ["🐶", "🐱", "🐹", "🐰", "🦊", "🐼"], // Animals
        ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"], // Sports
        ["🍓", "🍒", "🍑", "🥝", "🍇", "🍋"]  // Fruits
    ]
    
    static func randomTheme() -> [String] {
        return themes[Int.random(themes.count)]
    }
}
