//
//  Card.swift
//  Concentration
//
//  Created by Zhang, Yifan on 6/4/19.
//  Copyright © 2019 Zhang, Yifan. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    // doesn't need emoji var because the Model is UI-independent
    // so this Card struct should work for other types of matching games
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    mutating func resetCard() {
        self.isFaceUp = false
        self.isMatched = false
    }
    
    static var identifierFactory = 0;
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func resetIdentifier() {
        identifierFactory = 0
    }
    
    
    
}
