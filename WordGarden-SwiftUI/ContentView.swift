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
    @State private var currentWord = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var guessesRemaining = 8
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var guessLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @State private var playAgainButtonLabel = "Another Word?"
    @FocusState private var textFieldIsFocused: Bool
    
    private let wordsToGuess = ["SWIFT","DOG","CAT"]
    private let maximumGuessses = 8
    
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
                .frame(height: 80)
                .minimumScaleFactor(0.5)
                .padding()
            Spacer()
            //TODO: Switch to wordsToGuess[currentWord]
            Text(revealedWord)
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
                        .keyboardType(.asciiCapable)//選擇鍵盤形式
                        .submitLabel(.done)
                        .autocorrectionDisabled()//關閉自動修正
                        .textInputAutocapitalization(.characters)//自動大寫
                        .onChange(of: guessLetter) { _ in
                            guessLetter = guessLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessLetter.last
                            else{
                                return
                            }
                            guessLetter = String(lastChar).uppercased()
                        }
                        .onSubmit {
                            guard guessLetter != "" else {
                                return
                            }
                            guessALetter()
                            updateGamePlay()
                        }
                        .focused($textFieldIsFocused)
                    Button("Guess a Letter"){
                        //TODO: Guess a Letter Buttun action here
                        guessALetter()
                        updateGamePlay()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessLetter.isEmpty)
                }
            }
            else{
                Button(playAgainButtonLabel){
                    //TODO: Another Word Button action here
                    //if all words have been guessed...
                    if currentWord == wordsToGuess.count{
                        currentWord = 0
                        wordGuessed = 0
                        wordsMissed = 0
                        playAgainButtonLabel = "Anothor Word?"
                    }
                    wordToGuess = wordsToGuess[currentWord]
                    revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
                    lettersGuessed = ""
                    guessesRemaining = maximumGuessses
                    imageName = "flower\(guessesRemaining)"
                    gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
                    playAgainHidden = true
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
        .onAppear(){
            //show ____ when app start
            wordToGuess = wordsToGuess[currentWord]
            //CREATE A STRING FROM A REPEATING VALUE
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
            guessesRemaining = maximumGuessses
        }
    }
    func guessALetter(){
        textFieldIsFocused = false
        lettersGuessed = lettersGuessed + guessLetter
        revealedWord = ""

        //loop through all letters in wordToGuess
        for letter in wordToGuess{
            // check if letter in wordToGuess is in lettersGuessed(i.e. did you guess this letter already?)
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord+"\(letter) "
            } else {
                // if not, add an iunderscore + a blank space, to revealedWord
                revealedWord = revealedWord + "_ "
            }
        }
        revealedWord.removeLast()
    }
    func updateGamePlay(){
        if !wordToGuess.contains(guessLetter){
            guessesRemaining -= 1
            imageName = "flower\(guessesRemaining)"
        }
        if !revealedWord.contains("_"){
            //guess when no _ in revealedWord
            gameStatusMessage = "You've Guessed It! It Took You \(lettersGuessed.count)Guesses to Guess the Word."
            wordGuessed+=1
            currentWord+=1
            playAgainHidden = false
        } else if guessesRemaining == 0 {
            // Word Missed
            gameStatusMessage = "So Sorry. You're All Out of Guesses."
            wordsMissed+=1
            currentWord+=1
            playAgainHidden = false
        } else {
            gameStatusMessage = "You've Made \(lettersGuessed.count) Guess\(lettersGuessed.count==1 ? "" : "es")"
        }
        if currentWord == wordsToGuess.count{
            playAgainButtonLabel = "Restart Game?"
            gameStatusMessage = gameStatusMessage + "\nYou've Tried All of the Words. Restart from the Beginning?"
        }
        guessLetter = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
