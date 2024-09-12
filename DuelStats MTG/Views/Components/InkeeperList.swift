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
    @State private var playerNewDeck: Player = Player(name: "", decks: [], matches: [])
    
    var filteredSearch: [Player] {
        if !search.isEmpty {
            return players.filter { $0.name.lowercased().contains(search.lowercased()) }
        }
        return players
    }
    
    var body: some View {
        if players.isEmpty {
            ContentUnavailableView(
                "There are no players yet",
                systemImage: "person.slash.fill",
                description: Text("Add new players!")
            )
        } else if filteredSearch.isEmpty {
            ContentUnavailableView(
                "There are no players that matches that name",
                systemImage: "person.slash.fill",
                description: Text("Try with another name!")
            )
        } else {
            NavigationStack {
                ZStack {
                    List {
                        ForEach(filteredSearch, id: \.self) { player in
                            VStack {
                                HStack {
                                    Text(player.name)
                                        .font(.title2)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    Button {
                                        if !viewModel.playersSelected.keys.contains(player) {
                                            viewModel.selectPlayer(player, withDeck: player.decks.first ?? Deck(name: "", format: ""))
                                        } else {
                                            viewModel.unselectPlayer(player)
                                        }
                                    } label: {
                                        Image(systemName: viewModel.playersSelected.keys.contains(player) ? "circlebadge.fill" : "circlebadge")
                                            .foregroundStyle(viewModel.playersSelected.keys.contains(player) ? .green : .secondary)
                                            .imageScale(.large)
                                    }
                                }
                                
                                if viewModel.playersSelected.keys.contains(player) {
                                    Divider()
                                    Section {
                                        DecksInkeeperList(player: player)
                                    } header: {
                                        Text("Decks")
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {}
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("New deck")
                                        
                                        Image(systemName: "plus")
                                    }
                                    .font(.subheadline)
                                    .padding(.bottom, 5)
                                    .foregroundStyle(.salmon)
                                    .fontWeight(.semibold)
                                    .onTapGesture {
                                        playerNewDeck = player
                                        deckSheet.toggle()
                                    }
                                }
                            }
                            .searchable(text: $search, prompt: "Search for a player")
                            .sheet(isPresented: $deckSheet) {
                                AddDeckSheet(sheet: $deckSheet, player: $playerNewDeck)
                            }
                        }
                        .onDelete(perform: deletePlayer)
                    }
                }
            }
        }
        
    }
    
    func deletePlayer(_ indexSet: IndexSet) {
        for index in indexSet {
            let player = players[index]
            modelContext.delete(player)
        }
    }
}
