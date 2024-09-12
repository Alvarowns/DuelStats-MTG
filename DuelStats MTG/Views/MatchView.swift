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
    @Environment(\.modelContext) var modelContext
    
    @State private var someoneWon: Bool = false
    @State private var winner: Player = Player(name: "", decks: [], matches: [])
    @State private var winnerDeck: Deck = Deck(name: "", format: "")
    @State private var goBackAlert: Bool = false
    
    let players: [Player: Deck]
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(players.keys.sorted(by: { $0.name > $1.name }), id: \.self) { player in
                    HStack {
                        Text(player.name)
                        Text(players[player]?.name ?? "ERROR NOMBRE DECK")
                        Button {
                            winner = player
                            winnerDeck = players[player] ?? Deck(name: "", format: "")
                            someoneWon.toggle()
                        } label:{
                            Image(systemName: "crown.fill")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if viewModel.gameStarted {
                            goBackAlert.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .bold()
                            .font(.title3)
                            .foregroundStyle(.salmon)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .alert("\(winner.name) has won?", isPresented: $someoneWon) {
                Button("Yes") {
                    recordWinner(winner: winner, withDeck: winnerDeck)
                }
                Button("No", role: .destructive) {
                    
                }
            }
            .alert("Are you sure you want to end this game?", isPresented: $goBackAlert, actions: {
                Button("Yes") {
                    viewModel.gameStarted = false
                }
                
                Button("No", role: .cancel) {}
            })
            .onAppear {
                viewModel.gameStarted = true
            }
        }
    }
    
    func recordWinner(winner: Player, withDeck deck: Deck) {
        var playersID: [UUID] = []
        var decksID: [UUID] = []
        
        for player in players {
            playersID.append(player.key.id)
            decksID.append(player.value.id)
        }
        
        let match = SingleMatch(playersID: playersID, decksID: decksID, winnerID: winner.id, winnerDeckID: deck.id, date: .now)
        
        modelContext.insert(match)
    }
}
