//
//  WinnerPopUp.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 16/9/24.
//

import SwiftUI

struct WinnerPopUp: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    @Binding var someoneWon: Bool
    @Binding var winner: Player
    @Binding var deck: Deck
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .bold()
                .font(.title)
            Text(subtitle)
                .bold()
                .font(.headline)
            
            HStack {
                Button {
                    someoneWon = false
                } label: {
                    Text("No")
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button {
                    recordWinner(players: viewModel.playersSelected, winner: winner, withDeck: deck)
                    viewModel.playersSelected = [:]
                    viewModel.gameStarted = false
                } label: {
                    Text("Yes!")
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
            .frame(maxWidth: .infinity)
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.black)
                .shadow(color: .white, radius: 2)
        }
        .padding()
        .opacity(someoneWon ? 1.0 : 0.0)
    }
    
    func recordWinner(players: [Player: Deck], winner: Player, withDeck deck: Deck) {
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
