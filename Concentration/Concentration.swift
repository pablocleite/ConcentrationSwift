//
//  Concentration.swift
//  Concentration
//
//  Created by Pablo Leite on 17/06/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

class Concentration {
    lazy var cards = [Card]()

    var indexOfFacedUpCard: Int?
    var flipCount = 0
    var numberOfPairsOfCards = 0
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        cards.reserveCapacity(numberOfPairsOfCards)
        newGame()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfFacedUpCard, matchIndex != index {
                //Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFacedUpCard = nil
                flipCount += 1
            } else {
                //Either no cards or 2 cards are faced up.
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                if (indexOfFacedUpCard != index) {
                    flipCount += 1
                }
                cards[index].isFaceUp = true
                indexOfFacedUpCard = index
            }
        }
    }
    
    func newGame() {
        flipCount = 0
        cards.removeAll(keepingCapacity: true)
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //Appending a struct in Swift will create a copy of it.
        }
        shuffleCards()
    }
    
    func isFinished() -> Bool {
        var finished = true
        for card in cards {
            if !card.isMatched {
                finished = false
                break
            }
        }
        return finished
    }
    
    func shuffleCards() {
        var shuffledCards = [Card]()
        shuffledCards.reserveCapacity(cards.count)
        while !cards.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        cards = shuffledCards
    }
}
