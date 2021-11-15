//
//  EmojiMomroyGame.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 12/11/2021.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
   
    
    static let emojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓", "🦎", "🐪", "🦒", "🦬", "🐂", "🐎", "🐓", "🦨", "🦫", "🦜", "🐁", "🐿"]
    
    private var animalTheme: Theme, vehicleTheme: Theme, fruitTheme: Theme, foodTheme: Theme, flagTheme: Theme, activityTheme: Theme = Theme()
    private var themes: [Theme] = [Theme]()
    private(set) var currentTheme: Theme

    
    init() {
        let flagEmojis = ["🇮🇪", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🇺🇸", "🇦🇪", "🇹🇷", "🇵🇪", "🇱🇹", "🇱🇻", "🇭🇰", "🇬🇷", "🇬🇱"]
        let activityEmojis = ["⚽️", "🏀", "🏈", "🥎", "🎾", "🏐", "🎱", "🥊", "🛼", "⛸", "🏏", "🪁"]
        let animalemojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓", "🦎", "🐪", "🦒", "🦬", "🐂", "🐎", "🐓", "🦨", "🦫", "🦜", "🐁", "🐿"]
        let vehicleEmojis = ["🚗", "🚕", "🚙", "🚎", "🚚", "🚛", "🚜", "🚲", "🚔", "🚖", "🚘", "✈️"]
        let fruitEmojis = ["🍏", "🍎", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🥝", "🍓"]
        let foodEmojis = ["🥨", "🥐", "🥯", "🧅", "🧄", "🫒", "🥓", "🌭", "🍗", "🍕", "🌮", "🍣"]
        
        let themeNumbersOfPairsOfCards = [
           "animalPairNumbers": 10,
           "vehiclePairNumbers": 14,
           "fruitPairNumbers": 8,
           "foodPairNumbers": 10,
           "flagPairNumbers": 12,
           "activityPairNumber": 8
        ]

        
        func checkEmojiCount(forProposedNumberOfPairs numberOfPairs: Int, fromSetOfEmoji setOfEmoji: [String]) ->Int {
            numberOfPairs > setOfEmoji.count ? setOfEmoji.count : numberOfPairs
        }
        
        animalTheme = Theme(themeName: "Animals",
                            forEmojiSet: animalemojis,
                            withColour: "red") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["animalPairNumbers"] ?? 0, fromSetOfEmoji: animalemojis)
        }
        themes.append(animalTheme)
        
        vehicleTheme = Theme(themeName: "Vehicles",
                             forEmojiSet: vehicleEmojis,
                             withColour: "yellow") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["vehiclePairNumbers"] ?? 0, fromSetOfEmoji: vehicleEmojis)
        }
        themes.append(vehicleTheme)
        
        fruitTheme = Theme(themeName: "Fruit",
                           forEmojiSet: fruitEmojis,
                           withColour: "green") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["fruitPairNumbers"] ?? 0, fromSetOfEmoji: fruitEmojis)
        }
        themes.append(fruitTheme)
        
        foodTheme = Theme(themeName: "Food",
                          forEmojiSet: foodEmojis,
                          withColour: "blue") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["foodPairNumbers"] ?? 0, fromSetOfEmoji: foodEmojis)
        }
        themes.append(foodTheme)
        
        flagTheme = Theme(themeName: "Flags",
                          forEmojiSet: flagEmojis,
                          withColour: "orange") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["flagPairNumbers"] ?? 0, fromSetOfEmoji: flagEmojis)
        }
        themes.append(flagTheme)
        
        activityTheme = Theme(themeName: "Activities",
                              forEmojiSet: activityEmojis,
                              withColour: "brown") {
            checkEmojiCount(forProposedNumberOfPairs: themeNumbersOfPairsOfCards["activityPairNumber"] ?? 0, fromSetOfEmoji: activityEmojis)
        }
        themes.append(activityTheme)
        
        currentTheme = animalTheme
    }
    


    
    static func createMemoryGame(forTheme theme: Theme) -> MemoryGame<String> {
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in theme.emojiSet[pairIndex] }
    }

    func getColourForCurrentTheme() -> Color {
        let colourString = currentTheme.colour
        switch colourString {
        case "red" : return Color.red
        case "yellow": return Color.yellow
        case "green": return Color.green
        case "blue": return Color.blue
        case "orange": return Color.orange
        case "brown": return Color.brown
        default: return Color.blue
        }
    }
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(forTheme: Theme())
        
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }

    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card)
    }
    
    func changeTheme()  {
        let randomInt: Int = Int.random(in: 0..<themes.count)
        objectWillChange.send()
        currentTheme = themes[randomInt]
        model = EmojiMemoryGame.createMemoryGame(forTheme: currentTheme)
    
    }
    
}
