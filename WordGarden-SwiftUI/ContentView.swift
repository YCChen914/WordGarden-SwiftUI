//
//  ContentView.swift
//  WordGarden-SwiftUI
//
//  Created by 陳永承 on 2023/7/29.
//

import SwiftUI

struct ContentView: View {
    @State private var wordGuessed = 0
    @State private var wordsMissed = 0
    @State private var wordsToGuess = ["SWIFT","DOG","APPLE"]
    @State private var currentWord = 0
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var guessLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading){
                    Text("Word Guessed: \(wordGuessed)")
                    Text("Word Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Word to Guess: \(wordsToGuess.count - (wordGuessed+wordsMissed))")
                    Text("Word in Game: \(wordsToGuess.count)")
                }
            }
            Spacer()
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            //TODO: Switch to wordsToGuess[currentWord]
            Text("_ _ _ _ _")
                .font(.title)
            if playAgainHidden{
                HStack{
                    TextField("",text: $guessLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray,lineWidth: 2)
                        }
                    Button("Guess a Letter"){
                        //TODO: Guess a Letter Buttun action here
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                }
            }
            else{
                Button("Another Word?"){
                    //TODO: Another Word Button action here
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges:.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
