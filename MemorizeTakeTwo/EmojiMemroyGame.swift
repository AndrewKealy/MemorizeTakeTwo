//
//  EmojiMomroyGame.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 12/11/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    static let emojis = ["đ", "đ", "đ", "đĒ°", "đĻ", "đ", "đĨ", "đĻ", "đ", "đĻ", "đĻ", "đ", "đĻ", "đĒ", "đĻ", "đĻŦ", "đ", "đ", "đ", "đĻ¨", "đĻĢ", "đĻ", "đ", "đŋ"]
    
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
