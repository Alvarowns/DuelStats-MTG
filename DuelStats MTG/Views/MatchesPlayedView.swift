//
//  MatchesPlayedView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI
import SwiftData

struct MatchesPlayedView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    @Query(sort: \SingleMatch.date, order: .reverse) var matches: [SingleMatch]
    @Query var players: [Player]
    
    @State private var showInfo: Bool = false
    @State private var search: String = ""
    
    var filteredSearch: [SingleMatch] {
        if !search.isEmpty {
            let lowercasedSearch = search.lowercased()
                return matches.filter { match in
                    match.playersID.contains { id in
                        guard let player = players.first(where: { $0.id == id }) else { return false }
                        return player.name.lowercased().contains(lowercasedSearch)
                    }
                }
        }
        
        return matches
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    List {
                        ForEach(filteredSearch, id: \.self) { match in
                                VStack(alignment: .leading) {
                                    Text("\(match.date.formatted())")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    ForEach(players.filter({ player in match.playersID.contains(player.id) }) , id: \.self) { player in
                                        
                                        HStack {
                                            Image(systemName: "crown.fill")
                                                .foregroundStyle(.yellow)
                                                .opacity(player.id == match.winnerID ? 1.0 : 0.0)
                                                .font(.footnote)
                                            
                                            Text(player.name)
                                                .font(.subheadline)
                                                .foregroundStyle(player.id == match.winnerID ? .yellow : .secondary)
                                            
                                            Spacer()
                                            
                                            if let deck = player.decks.first(where: { deck in
                                                match.decksID.contains(deck.id)
                                            }) {
                                                HStack {
                                                    Text(deck.name)
                                                    Text("(\(deck.format.capitalized))")
                                                        .foregroundStyle(.secondary)
                                                        .font(.footnote)
                                                }
                                                .font(.subheadline)
                                                .foregroundStyle(player.id == match.winnerID ? .yellow : .secondary)
                                            }
                                        }
                                    }
                            }
                        }
                        .onDelete(perform: deleteMatch(_:))
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
                    .listStyle(.plain)
                    .scrollIndicators(.never)
                    .disabled(showInfo ? true: false)
                    .blur(radius: showInfo ? 3 : 0)
                }
                .background {
                    Image(uiImage: viewModel.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                
                InfoPopUp(showInfo: $showInfo, title: "You can swipe left to delete any match", subtitle: "Be careful, this action will remove the match permanently!", message: "")
            }
            .searchable(text: $search, prompt: "Search for a player")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                Text("Matches")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                    .bold()
            }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .bold()
                    }
                    .shadow(radius: 1)
                    .shadow(radius: 1)
                }
            }
        }
    }
    
    func deleteMatch(_ indexSet: IndexSet) {
        for index in indexSet {
            let match = matches[index]
            modelContext.delete(match)
        }
    }
}
