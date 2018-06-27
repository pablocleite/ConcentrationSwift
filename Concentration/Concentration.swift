//
//  Concentration.swift
//  Concentration
//
//  Created by Pablo Leite on 17/06/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()

    private var indexOfFacedUpCard: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set(newValue) {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = (cardIndex == newValue)
            }
        }
    }
    
    var isFinished:Bool {
        var finished = true
        for card in cards {
            if !card.isMatched {
                finished = false
                break
            }
        }
        return finished
    }
    
    private var numberOfPairsOfCards = 0
    var flipCount = 0
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards != 0, "Concentrarion.init(numberOfPairsOfCards: Int): number of pair of cards must be greather than 0.")
        self.numberOfPairsOfCards = numberOfPairsOfCards
        cards.reserveCapacity(numberOfPairsOfCards)
        newGame()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentrarion.chooseCard(at: index:Int): Chosen index not in cards.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfFacedUpCard, matchIndex != index {
                //Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                flipCount += 1
            } else {
                //Either no cards or 2 cards are faced up.
                if (indexOfFacedUpCard != index) {
                    flipCount += 1
                }
                indexOfFacedUpCard = index
            }
        }
    }
    
    mutating func newGame() {
        flipCount = 0
        cards.removeAll(keepingCapacity: true)
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //Appending a struct in Swift will create a copy of it.
        }
        shuffleCards()
    }
    
    private mutating func shuffleCards() {
        var shuffledCards = [Card]()
        shuffledCards.reserveCapacity(cards.count)
        while !cards.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        cards = shuffledCards
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
