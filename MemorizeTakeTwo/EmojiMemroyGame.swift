//
//  EmojiMomroyGame.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 12/11/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
   
    
    private static let emojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓", "🦎", "🐪", "🦒", "🦬", "🐂", "🐎", "🐓", "🦨", "🦫", "🦜", "🐁", "🐿"]
    typealias Card = MemoryGame<String>.Card

    private static func createMemoryGame() -> MemoryGame<String> {
        
        
        return MemoryGame<String>(numberOfPairsOfCards: 9) { pairIndex in emojis[pairIndex] }
    }

    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
        
    var cards: Array<Card> {
        model.cards
    }
    

    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        objectWillChange.send()
        model.choose(card)
    }

    
}
