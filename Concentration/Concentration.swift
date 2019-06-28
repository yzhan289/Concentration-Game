//
//  Concentration.swift
//  Concentration
//
//  Created by Zhang, Yifan on 6/4/19.
//  Copyright © 2019 Zhang, Yifan. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(String(describing: index))): must have at least one pair of cards")
//        assert(numberOfPairsOfCards < 5, "Concentration.init(at: \(String(describing: index))): must have at most 4 pairs")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            //            let matchingCard = card // copies card since Card() is a struct!
            cards.append(card)
            cards.append(card) // can also ignore matchingCard since card makes a copy of itself rather than adding the same card, again using struct
        }
    }
    
    mutating func chooseCard(at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func shuffleCards() {
        // reset the identifiers for all cards
        Card.resetIdentifier()
        
        // reset the face values for each card
        for index in stride(from: cards.count-1, to: 0, by:-1)  {
            let tempCard = cards[index]
            let randomIndex = Int.random(in: 0 ..< index)
            cards[index] = cards[randomIndex]
            cards[randomIndex] = tempCard
            
        }
//        print("Cards are shuffled")

    }
    
}
