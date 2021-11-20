//
//  MemorizeTakeTwoApp.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 05/11/2021.
//

import SwiftUI

@main
struct MemorizeTakeTwoApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
