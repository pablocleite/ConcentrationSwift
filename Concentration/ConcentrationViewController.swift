//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Pablo Leite on 16/06/2018.
//  Copyright © 2018 Pablo Cobucci Leite. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    private let emojiChoices = ["🎃", "👻", "😼", "⛄️", "🐼", "🦊"]
    private lazy var availableEmojis = emojiChoices
    private var emoji = [Int:String]()

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    //TODO Find a way of doing this without ctrl+drag
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game.newGame()
        availableEmojis = emojiChoices
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: " + String(game.flipCount)
        newGameButton.isHidden = !game.isFinished
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, !availableEmojis.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(availableEmojis.count)))
            emoji[card.identifier] = availableEmojis.remove(at: randomIndex)
        }
        //Same as if emoji[card.identifier] != nil ? emoji[card.identifier] : "?"
        return emoji[card.identifier] ?? "?"
    }
}

