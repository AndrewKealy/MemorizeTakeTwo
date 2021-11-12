//
//  ContentView.swift
//  MemorizeTakeTwo
//
//  Created by Andrew Kealy on 05/11/2021.
//

import SwiftUI

struct ContentView: View {

    @State var emojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓"]
    
    

    let musicEmojis = ["🎶", "🎼", "🎵", "🎹", "🎤", "🎸", "🎧", "🥁", "🎻", "🎺", "🪕", "🪘"]
    let animalEmojis = ["🐝", "🐛", "🐜", "🪰", "🦋", "🐌", "🐥", "🦞", "🐒", "🦓", "🦏", "🐓"]
    let transportEmojis = ["🚗", "🛻", "🏍", "✈️", "🚕", "🚙" , "🚌",  "🚎", "🏎", "🚑", "🚒", "🚐", "🚍", "🛵", "🚲", "🚟", "🚁", "🛳", "⛵️", "🛶", "🚖", "🚘", "🚔", "🛺"]
    
    
    @State var emojiCount: Int = 8
    let minimumNumberOfCards = 4
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            titleLabel.font(.system(size: 24.0))
                .padding()
            

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 200))])  {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }           .foregroundColor(.red)
            Spacer()
            HStack {
                animalCards
                Spacer()
                transportCards
                Spacer()
                musicCards

            }.font(.largeTitle)
                .padding(.horizontal)
            
            
        }        .padding(.horizontal)
        
    }
    

    var titleLabel: some View {
        Label {
            Text("Memorize")
                .foregroundColor(.blue)
        } icon: {
            Image(systemName: "brain.head.profile")
        }
    }
        
    
    var animalCards: some View {
        Button {
            emojis = animalEmojis.shuffled()
            emojiCount = getRandomNumberofCards(forArrayCount: animalEmojis.count)
            
        } label: {
            ButtonLabelView(buttonLabelText: "Animals", buttonLabelImage: "tortoise")
        }
}
    
    var transportCards: some View {
        Button {
            emojis = transportEmojis.shuffled()
            emojiCount = getRandomNumberofCards(forArrayCount: transportEmojis.count)
            
        } label: {
            ButtonLabelView(buttonLabelText: "Transport", buttonLabelImage: "car")
        }
    }
    
    var musicCards: some View {
        Button {
            emojis = musicEmojis.shuffled()
            emojiCount = getRandomNumberofCards(forArrayCount: musicEmojis.count)
            
        } label: {
            ButtonLabelView(buttonLabelText: "Music", buttonLabelImage: "guitars")
            
        }
    }
    func getRandomNumberofCards(forArrayCount arrayCount: Int) -> Int {
        return Int.random(in: minimumNumberOfCards...arrayCount)
    }

}




struct ButtonLabelView: View {
    var buttonLabelText: String
    var buttonLabelImage: String
    var body: some View {
        VStack {
            Image(systemName: buttonLabelImage).font(.largeTitle)
            Text(buttonLabelText).font(.system(size: 12.0 ))
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
                
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
