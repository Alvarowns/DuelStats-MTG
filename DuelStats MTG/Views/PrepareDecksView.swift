//
//  PrepareDecksView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 15/9/24.
//

import SwiftUI

struct PrepareDecksView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    @State private var decksSelected: [Deck] = []
    
    let players: [Player]
    
    var body: some View {
        VStack {
            List {
                ForEach(players, id: \.self) { player in
                        Section {
                            ForEach(player.decks, id: \.self) { deck in
                                HStack {
                                    Text(deck.name)
                                    
                                    Spacer()
                                    
                                    Image(systemName: decksSelected.contains(deck) ? "circlebadge.fill" : "circlebadge")
                                        .font(.title)
                                        .foregroundStyle(.orange)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if !decksSelected.contains(deck) {
                                        decksSelected.append(deck)
                                    } else {
                                        decksSelected.removeAll { $0 == deck }
                                    }
                                }
                            }
                        } header: {
                            Text(player.name)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .bold()
                                .shadowPop()
                        }
                }
                .listRowBackground(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.black.opacity(0.6))
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.black)
                    }
                )
            }
            .padding()
            .listStyle(.plain)
            .scrollIndicators(.never)
            
            VStack(spacing: 0) {
                Text("Select at least 1 deck per player to start a game")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .shadowPop()
                
                Button {
                    addDecksToPlayers()
                    print(viewModel.playersSelected)
                    viewModel.gameStarted.toggle()
                } label: {
                    Text("Start Game")
                        .font(.title3)
                        .bold()
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.black)
                }
                .disabled(decksSelected.count < players.count ? true : false)
                .buttonStyle(.borderedProminent)
                .shadowPop()
                .padding()
            }
        }
        .background {
            Image(uiImage: viewModel.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
    
    func addDecksToPlayers() {
        var playersAndDecks: [Player: Deck] = [:]
        
        for player in players {
            for deck in decksSelected {
                if player.decks.contains(deck) {
                    playersAndDecks.updateValue(deck, forKey: player)
                }
            }
        }
        
        viewModel.playersSelected = playersAndDecks
    }
}
