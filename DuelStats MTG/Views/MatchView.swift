//
//  MatchView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI
import SwiftData

struct MatchView: View {
    @EnvironmentObject private var viewModel: MatchVM
    @Environment(\.modelContext) var modelContext
    
    @State private var someoneWon: Bool = false
    @State private var winner: Player = Player(name: "", decks: [], matches: [])
    @State private var winnerDeck: Deck = Deck(name: "", format: "")
    
    let players: [Player: Deck]
    
    var body: some View {
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
        .alert("\(winner.name) has won?", isPresented: $someoneWon) {
            Button("Yes") {
                recordWinner(winner: winner, withDeck: winnerDeck)
            }
            Button("No", role: .destructive) {
                
            }
        }
    }
    
    func recordWinner(winner: Player, withDeck deck: Deck) {
        var playersRecord: [Player] = []
        var decksRecord: [Deck] = []
        
        for item in players {
            playersRecord.append(item.key)
            decksRecord.append(item.value)
        }
        
        let match: SingleMatch = SingleMatch(players: playersRecord, decks: decksRecord, winner: winner, winnerDeck: deck, date: .now)
        
        for player in playersRecord {
            player.matches.append(match)
            print(player.matches)
        }
    }
}
