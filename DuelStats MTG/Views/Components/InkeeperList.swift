//
//  InkeeperList.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

struct InkeeperList: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    @Query var players: [Player]
    
    @State private var search: String = ""
    @State private var deckSheet: Bool = false
    @State private var deckName: String = ""
    @State private var playerNewDeck: Player = Player(name: "", decks: [], favorite: false, matches: [])
    
    var filteredSearch: [Player] {
        if !search.isEmpty {
            return players.filter { $0.name.lowercased().contains(search.lowercased()) }.sorted { $0.favorite && !$1.favorite }
        }
        return players.sorted { $0.favorite && !$1.favorite }
    }
    
    var body: some View {
            NavigationStack {
                ZStack {
                    if players.isEmpty {
                        ContentUnavailableView(
                            "There are no players yet",
                            systemImage: "person.slash.fill",
                            description: Text("Add new players!").foregroundStyle(.white)
                        )
                        .shadowPop()
                    } else if filteredSearch.isEmpty {
                        ContentUnavailableView(
                            "There are no players that matches that name",
                            systemImage: "person.slash.fill",
                            description: Text("Try with another name!").foregroundStyle(.white)
                        )
                        .shadowPop()
                    } else {
                        List {
                            ForEach(filteredSearch, id: \.self) { player in
                                NavigationLink(value: player) {
                                    VStack {
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .font(.title2)
                                                .foregroundStyle(.orange)
                                                .opacity(player.favorite ? 1.0 : 0.0)
                                            
                                            
                                            Text(player.name)
                                                .font(.title2)
                                                .bold()
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 10)
                                    }
                                    .padding(5)
                                }
                                .listRowBackground(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundStyle(.black.opacity(0.6))
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(lineWidth: 3)
                                            .foregroundStyle(.black)
                                    }
                                        .padding(5)
                                )
                            }
                            .onDelete(perform: deletePlayer)
                            .sheet(isPresented: $deckSheet) {
                                AddDeckSheet(sheet: $deckSheet, player: playerNewDeck)
                            }
                        }
                        .padding()
                        .listStyle(.plain)
                        .navigationDestination(for: Player.self) { player in
                            PlayerProfile(player: player)
                        }
                    }
                }
                .searchable(text: $search, prompt: "Search for a player")
            }
    }
    
    func deletePlayer(_ indexSet: IndexSet) {
        for index in indexSet {
            let player = players[index]
            modelContext.delete(player)
        }
    }
}
