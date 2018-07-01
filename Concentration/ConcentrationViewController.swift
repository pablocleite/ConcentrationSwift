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
    
    private let labelStringAttributes: [NSAttributedStringKey : Any] = [
        NSAttributedStringKey.strokeWidth : 3.0,
        NSAttributedStringKey.strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    ]

    private var availableEmojis: [String] = []
    private var emoji = [Card:String]()

    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCount()
        }
    }
    @IBOutlet weak var cardsStackView: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    @IBOutlet weak var newGameButton: UIButton!
    //TODO Find a way of doing this without ctrl+drag
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
        } else {
            print("chosen card was not in cardButtons")
        }
        updateViewFromModel()
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        initGame()
    }
    
    override func viewDidLoad() {
        initGame();
    }
    
    private func initGame() {
        game.newGame()
        availableEmojis = ThemeFactory.randomTheme()
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
        updateFlipCount()
        updateScoreLabel()
        newGameButton.isHidden = !game.isFinished
        cardsStackView.isHidden = game.isFinished
    }
    
    private func updateFlipCount() {
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: labelStringAttributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreLabel() {
        let attributedString = NSAttributedString(string: "Score: \(game.score)", attributes: labelStringAttributes)
        scoreLabel.attributedText = attributedString
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, !availableEmojis.isEmpty {
            emoji[card] = availableEmojis.remove(at: Int.random(availableEmojis.count))
        }
        //Same as if emoji[card.identifier] != nil ? emoji[card.identifier] : "?"
        return emoji[card] ?? "?"
    }
}

