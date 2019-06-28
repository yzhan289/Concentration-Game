//
//  ViewController.swift
//  Concentration
//
//  Created by Zhang, Yifan on 6/4/19.
//  Copyright © 2019 Zhang, Yifan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return ((cardButtons.count + 1) / 2)
    }
    // comment hello
    private(set) var flipCount = 0 {
        didSet {
            flipCounterLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // as emoji's are chosen, take the elements out of the array
    private var emojiChoices = ["😂", "👻", "😑", "😇", "😎", "🤨", "🤪", "🥶"]
    
    // keep the array of original emojis
    private let totalChoices = ["😂", "👻", "😑", "😇", "😎", "🤨", "🤪", "🥶"]
    
    var emoji = [Int:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBOutlet private weak var flipCounterLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1803921569, blue: 0.3254901961, alpha: 1)
            
        }
        
        // refill the emoji choices
        emojiChoices = totalChoices

        // shuffle cards
        game.shuffleCards()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            
            // find the value of the button that is tapped
            let button = cardButtons[index] // UI of the button
            let card = game.cards[index] // card value
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0.1215686275, green: 0.1803921569, blue: 0.3254901961, alpha: 1)
            }
        }
    }
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?" // same code as above
    }
    
}

// making a new function in the class Int called arc4random to generate a random int from 0 up to but not including itself
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
