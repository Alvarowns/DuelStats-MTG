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
        ZStack {
            VStack(spacing: 0) {
                if viewModel.playersSelected.count == 3 || viewModel.playersSelected.count == 4 {
                    HStack(spacing: 0) {
                        PlayerSmallView(
                            someoneWon: $someoneWon,
                            playerWon: $winner,
                            deckWon: $winnerDeck,
                            player: Array(
                                viewModel.playersSelected.keys
                            )[1],
                            deck: Array(viewModel.playersSelected.values)[1],
                            rotation: 90
                        )
                        
                        PlayerSmallView(
                            someoneWon: $someoneWon,
                            playerWon: $winner,
                            deckWon: $winnerDeck,
                            player: Array(viewModel.playersSelected.keys)[2],
                            deck: Array(viewModel.playersSelected.values)[2],
                            rotation: -90
                        )
                    }
                } else if viewModel.playersSelected.count == 2 {
                    PlayerView(
                        someoneWon: $someoneWon,
                        playerWon: $winner,
                        deckWon: $winnerDeck,
                        player: Array(viewModel.playersSelected.keys)[1],
                        deck: Array(viewModel.playersSelected.values)[1]
                    )
                    .rotationEffect(.degrees(180))
                }
                
                if viewModel.playersSelected.count == 4 {
                    HStack(spacing: 0) {
                        PlayerSmallView(
                            someoneWon: $someoneWon,
                            playerWon: $winner,
                            deckWon: $winnerDeck,
                            player: Array(
                                viewModel.playersSelected.keys
                            )[0],
                            deck: Array(viewModel.playersSelected.values)[0],
                            rotation: 90
                        )
                        
                        PlayerSmallView(
                            someoneWon: $someoneWon,
                            playerWon: $winner,
                            deckWon: $winnerDeck,
                            player: Array(viewModel.playersSelected.keys)[3],
                            deck: Array(viewModel.playersSelected.values)[3],
                            rotation: -90
                        )
                    }
                    .ignoresSafeArea(edges: .bottom)
                } else {
                    PlayerView(
                        someoneWon: $someoneWon,
                        playerWon: $winner,
                        deckWon: $winnerDeck,
                        player: Array(viewModel.playersSelected.keys)[0],
                        deck: Array(viewModel.playersSelected.values)[0]
                    )
                }
            }
            .onAppear {
                viewModel.gameStarted = true
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
            MenuView()
            
            WinnerPopUp(someoneWon: $someoneWon, winner: $winner, deck: $winnerDeck, title: "Is \(winner.name) the winner?", subtitle: "Deck: \(winnerDeck.name)")
        }
    }
}
