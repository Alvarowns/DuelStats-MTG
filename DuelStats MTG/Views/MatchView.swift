//
//  MatchView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI
import SwiftData

struct MatchView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    @State private var someoneWon: Bool = false
    @State private var winner: Player = Player(name: "", decks: [], favorite: false, matches: [])
    @State private var winnerDeck: Deck = Deck(name: "", format: "", hasBeenDeleted: false)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    if viewModel.playersSelected.count == 2 {
                        PlayerView(someoneWon: $someoneWon, playerWon: $winner, deckWon: $winnerDeck, player: Array(viewModel.playersSelected.keys)[0], deck: Array(viewModel.playersSelected.values)[0])
                            .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                            .frame(maxHeight: .infinity)
                        
                        MenuView()
                        
                        PlayerView(someoneWon: $someoneWon, playerWon: $winner, deckWon: $winnerDeck, player: Array(viewModel.playersSelected.keys)[1], deck: Array(viewModel.playersSelected.values)[1])
                            .frame(maxHeight: .infinity)
                    }
                }
                .blur(radius: someoneWon ? 3.0 : 0.0)
                .disabled(someoneWon ? true : false)
                
                WinnerPopUp(someoneWon: $someoneWon, winner: $winner, deck: $winnerDeck, title: "Did \(winner.name) won?", subtitle: "Deck: \(winnerDeck.name)")
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.gameStarted = true
        }
    }
}
