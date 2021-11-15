//
//  MemoryGameModel.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 12/11/2021.
//

import Foundation
import UIKit

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    var score = 0
    private var alreadySeen: [Int] = []
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if !alreadySeen.contains(card.id){
                    
                    alreadySeen.append(card.id)
                    print(alreadySeen)
                } else {
                    score -= 1
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    

    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numbersofPairsOfCards x 2 to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards = cards.shuffled()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

struct Theme {
    var name: String = "Animals"
    private(set) var numberOfPairsOfCards: Int = 10
    private(set) var emojiSet: [String] =  ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓", "🦎", "🐪", "🦒", "🦬", "🐂", "🐎", "🐓", "🦨", "🦫", "🦜", "🐁", "🐿"]

    var colour: String = "red"

    init(){
        
    }
    init(themeName: String, forEmojiSet themeEmojiSet: [String], withColour themeColour: String, getNumberOfCards: () ->Int) {
        name = themeName
        numberOfPairsOfCards = getNumberOfCards()
        var emojiSelection =  Array<String>()
        if themeEmojiSet.count != numberOfPairsOfCards {
            for _ in  0..<numberOfPairsOfCards {
                var emojiToAppend: String? = themeEmojiSet.randomElement()
                while(emojiToAppend == nil || emojiSelection.contains(emojiToAppend!)) {
                    emojiToAppend = themeEmojiSet.randomElement()
                }
                emojiSelection.append(emojiToAppend!)
            }
            emojiSet = emojiSelection
        } else {
            emojiSet = themeEmojiSet
        }
        colour = themeColour
   }
    

    
}
