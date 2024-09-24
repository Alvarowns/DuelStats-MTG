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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query(sort: \SingleMatch.date, order: .reverse) var matches: [SingleMatch]
    @Query var players: [Player]
    
    @State private var showInfo: Bool = false
    @State private var settings: Bool = false
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
    
    var groupedMatchesByDate: [Date: [SingleMatch]] {
        Dictionary(grouping: filteredSearch) { match in
            Calendar.current.startOfDay(for: match.date)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if groupedMatchesByDate.isEmpty {
                        ContentUnavailableView(
                            "There are no matches yet",
                            systemImage: "rectangle.portrait.on.rectangle.portrait.slash.fill",
                            description: Text("Start a game!").foregroundStyle(.white)
                        )
                        .shadowPop()
                    } else if filteredSearch.isEmpty {
                        ContentUnavailableView(
                            "There are no matches with that player",
                            systemImage: "person.slash.fill",
                            description: Text("Try with another name!").foregroundStyle(.white)
                        )
                        .shadowPop()
                    } else {
                        List {
                            ForEach(groupedMatchesByDate.keys.sorted(by: >), id: \.self) { date in
                                Section {
                                    ForEach(groupedMatchesByDate[date] ?? [], id: \.self) { match in
                                        VStack(alignment: .leading) {
                                            ForEach(players.filter({ player in match.playersID.contains(player.id) }), id: \.self) { player in
                                                HStack {
                                                    Image(systemName: "crown.fill")
                                                        .foregroundStyle(.yellow)
                                                        .opacity(player.id == match.winnerID ? 1.0 : 0.0)
                                                        .font(.footnote)
                                                    
                                                    Text(player.name)
                                                        .font(.subheadline)
                                                        .foregroundStyle(player.id == match.winnerID ? .yellow : .secondary)
                                                    
                                                    Spacer()
                                                    
                                                    ForEach(player.decks.filter({ deck in match.decksID.contains(deck.id) }), id: \.self) { deck in
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
                                } header: {
                                    Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                        .foregroundStyle(.white)
                                }
                                .shadowPop()
                            }
                        }
                        .listStyle(.plain)
                        .scrollIndicators(.never)
                        .disabled(showInfo ? true: false)
                        .blur(radius: showInfo ? 3 : 0)
                    }
                }
                .padding()
                .background {
                    Image(uiImage: viewModel.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                
                InfoPopUp(showInfo: $showInfo, title: "You can swipe left to delete any match", subtitle: "Be careful, this action will remove the match permanently!", message: "")
            }
            .searchable(text: $search, prompt: "Search for a player")
            .fullScreenCover(isPresented: $settings) {
                Settings()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Matches")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadowPop()
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            showInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .bold()
                        }
                        .shadowPop()
                        
                        Button {
                            settings.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                                .bold()
                        }
                        .shadowPop()
                    }
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

