//
//  EmojiMomroyGame.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 12/11/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓", "🦎", "🐪", "🦒", "🦬", "🐂", "🐎", "🐓", "🦨", "🦫", "🦜", "🐁", "🐿"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in EmojiMemoryGame.emojis[pairIndex] }
    }

    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card)
    }
    
}
