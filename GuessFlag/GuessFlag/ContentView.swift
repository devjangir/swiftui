//
//  ContentView.swift
//  GuessFlag
//
//  Created by Devdutt Jangir on 05/08/20.
//  Copyright © 2020 Devdutt Jangir. All rights reserved.
//

import SwiftUI
struct TitleModifier : ViewModifier {
    func body(content : Content) -> some View {
        content
            .font(.largeTitle)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleModifier())
    }
}   
struct ContentView: View {
    @State private var showResult = false
    @State private var resultTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack(spacing:20) {
                    Text("Tap the flag")
                        .foregroundColor(.white)
                        .titleStyle()
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                }
                
                ForEach(0...2, id:\.self) { number in
                    Button(action:{
                        self.checkAnswer(number: number)
                    }) {
                        FlagView(imageName:self.countries[number])
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showResult) {
            Alert(title: Text("Guess Flag"), message: Text(self.resultTitle), dismissButton:  .default(Text("Ok"), action: {
                self.resetGame()
            }))
        }
    }
    func checkAnswer(number:Int) {
        if number == correctAnswer {
            self.resultTitle = "Correct"
        } else {
            self.resultTitle = "Wrong"
        }
        self.showResult = true
    }
    
    func resetGame() {
        countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagView: View {
    let imageName:String
    var body: some View {
        Image(self.imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black,lineWidth: 2))
        .shadow(radius: 2)
        
    }
}
