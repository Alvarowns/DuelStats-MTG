//
//  PrepareMatch.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 14/9/24.
//

import SwiftUI
import SwiftData

struct PrepareMatch: View {
    @EnvironmentObject private var viewModel: MainVM
    @Query var players: [Player]
    
    @State private var search: String = ""
    @State private var playersSelected: [Player] = []
    @State private var goToDecks: Bool = false
    
    var filteredSearch: [Player] {
        if !search.isEmpty {
            return players.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
        return players
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if players.isEmpty {
                    ContentUnavailableView(
                        "There are no players yet",
                        systemImage: "person.slash.fill",
                        description: Text("Add new players!")
                    )
                    .shadowPop()
                } else if filteredSearch.isEmpty {
                    ContentUnavailableView(
                        "There are no players that matches that name",
                        systemImage: "person.slash.fill",
                        description: Text("Try with another name!")
                    )
                    .shadowPop()
                } else {
                    VStack {
                        List {
                            ForEach(filteredSearch, id: \.self) { player in
                                VStack {
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .font(.title2)
                                            .foregroundStyle(.yellow)
                                            .opacity(player.favorite ? 1.0 : 0.0)
                                        
                                        
                                        Text(player.name)
                                            .font(.title2)
                                            .bold()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Spacer()
                                        
                                        Image(systemName: playersSelected.contains(player) ? "circlebadge.fill" : "circlebadge")
                                            .font(.largeTitle)
                                            .foregroundStyle(.orange)
                                    }
                                    .padding(.vertical, 10)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if !playersSelected.contains(player) {
                                        playersSelected.append(player)
                                    } else {
                                        playersSelected.removeAll { $0 == player }
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
                        }
                        .padding()
                        .listStyle(.plain)
                        
                        VStack(spacing: 0) {
                            Text("Select at least 2 players to start a game")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .shadowPop()
                            
                            Button {
                                goToDecks.toggle()
                            } label: {
                                Text("Select Decks")
                                    .font(.title3)
                                    .bold()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.black)
                            }
                            .disabled(playersSelected.count > 1 ? false : true)
                            .buttonStyle(.borderedProminent)
                            .shadowPop()
                            .padding()
                        }
                    }
                    .navigationDestination(isPresented: $goToDecks) {
                        PrepareDecksView(players: playersSelected)
                    }
                }
            }
            .background {
                Image(uiImage: viewModel.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .searchable(text: $search, prompt: "Search for a player")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Prepare the Match")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                        .shadowPop()
                }
            }
        }
    }
}
