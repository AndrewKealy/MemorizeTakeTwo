//
//  ContentView.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 05/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    var body: some View {
        
        
        VStack {
            ScrollView {
                titleLabel.font(.system(size: 24.0))
                    .padding()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 200))])  {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }           .foregroundColor(viewModel.getColourForCurrentTheme())
        Spacer()
            HStack {
                themeButton
                Spacer()
                scoreLabel
            }
            
        }
        .padding(.horizontal)
    }
    
    
    
    var titleLabel: some View {
        Label {
            Text(viewModel.currentTheme.name)
                .foregroundColor(.blue)
        } icon: {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(.gray)
            
            
        }
    }
    
    var themeButton: some View {
        Button(action: {
            viewModel.changeTheme()
            })  {
                Label("Change \n theme", systemImage: "square.grid.4x3.fill").font(.system(size: 12))
            } .buttonStyle(.bordered)
            
    }
    
    var scoreLabel: some View {
        Label("Score: \(viewModel.score)", systemImage: "bolt.fill")
            .labelStyle(.titleOnly)
    }
}
    
struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
                
            }
        }
        
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }

