//
//  Card.swift
//  Concentration
//
//  Created by Pablo Leite on 17/06/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return identifier }
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var  identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func == (lhs:Card, rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
