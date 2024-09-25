//
//  PrepareDecksView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 15/9/24.
//

import SwiftUI
import SwiftData

struct PrepareDecksView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Query var background: [BackgroundPersistent]
    
    @State private var selecteds: [Player: Deck] = [:]
    
    let players: [Player]
    
    var body: some View {
        VStack {
            List {
                ForEach(players, id: \.self) { player in
                        Section {
                            ForEach(player.decks.filter({ $0.hasBeenDeleted == false }), id: \.self) { deck in
                                HStack {
                                    Text(deck.name)
                                    
                                    Spacer()
                                    
                                    Image(systemName: selecteds[player] == deck ? "circlebadge.fill" : "circlebadge")
                                        .font(.title)
                                        .foregroundStyle(.orange)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selecteds.updateValue(deck, forKey: player)
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
                    viewModel.playersSelected = selecteds
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
                .disabled(selecteds.count < players.count ? true : false)
                .buttonStyle(.borderedProminent)
                .shadowPop()
                .padding()
            }
        }
        .background {
            if let background = background.first?.image {
                Image("\(background)")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .ignoresSafeArea()
            } else {
                Image(uiImage: viewModel.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .ignoresSafeArea()
            }
        }
    }
}
