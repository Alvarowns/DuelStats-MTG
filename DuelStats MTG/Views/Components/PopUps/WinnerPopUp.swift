//
//  WinnerPopUp.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 16/9/24.
//

import SwiftUI
import SwiftData

struct WinnerPopUp: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    @Query var background: [BackgroundPersistent]
    
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
                .shadowPop()
            
            Image(.trophy)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
                .shadowPop()
            
            Text(subtitle)
                .bold()
                .font(.headline)
                .shadowPop()
            
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
                .shadowPop()
                
                Button {
                    recordWinner(players: viewModel.playersSelected, winner: winner, withDeck: deck)
                    viewModel.gameStarted = false
                } label: {
                    Text("Yes!")
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .shadowPop()
            }
            .frame(maxWidth: .infinity)
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .padding()
        .background {
            if let background = background.first?.image {
                Image("\(background)")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                Image(uiImage: viewModel.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .shadowPop()
        .shadowPop()
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
