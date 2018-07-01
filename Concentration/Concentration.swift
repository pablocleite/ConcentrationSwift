//
//  Concentration.swift
//  Concentration
//
//  Created by Pablo Leite on 17/06/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import Foundation

struct Concentration {
    private let pointsForMatch = 2
    private let pointsForPenalty = -1

    private(set) var indexOfFacedUpCard: Int? {
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
        return cards.filter {!$0.isMatched}.isEmpty
    }
    
    private(set) var cards = [Card]()
    private var knownCardIndices = Set<Int>()
    private var numberOfPairsOfCards = 0
    private(set) var flipCount = 0
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards != 0, "Concentrarion.init(numberOfPairsOfCards: Int): number of pair of cards must be greather than 0.")
        self.numberOfPairsOfCards = numberOfPairsOfCards
        cards.reserveCapacity(numberOfPairsOfCards)
        knownCardIndices.reserveCapacity(numberOfPairsOfCards)
        newGame()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentrarion.chooseCard(at: index:Int): Chosen index not in cards.")
        let chosenCard = cards[index]
        let alreadyKnewCard = !knownCardIndices.insert(index).inserted
        if !chosenCard.isMatched {
            if let matchIndex = indexOfFacedUpCard, matchIndex != index {
                //Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    updateScore(match: true)
                } else if alreadyKnewCard{
                    updateScore(match:false)
                }
                cards[index].isFaceUp = true
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
        score = 0
        flipCount = 0
        knownCardIndices.removeAll(keepingCapacity: true)
        cards.removeAll(keepingCapacity: true)
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //Appending a struct in Swift will create a copy of it.
        }
        cards.shuffle()
    }
    
    private mutating func updateScore(match: Bool) {
        score += match ? pointsForMatch : pointsForPenalty
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
