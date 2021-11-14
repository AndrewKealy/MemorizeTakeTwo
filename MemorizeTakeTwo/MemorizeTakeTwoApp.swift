//
//  MemorizeTakeTwoApp.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 05/11/2021.
//

import SwiftUI

@main
struct MemorizeTakeTwoApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
