//
//  PlayerProfile.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 13/9/24.
//

import SwiftUI
import Charts
import SwiftData

struct PlayerProfile: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query(sort: \SingleMatch.date, order: .reverse) var matches: [SingleMatch]
    @Query var players: [Player]
    
    @State private var editDeck: Bool = false
    @State private var addDeck: Bool = false
    @State private var deleteDeck: Bool = false
    @State private var showDeletedDecks: Bool = false
    @State private var deckToEdit: Deck = Deck(name: "", format: "", hasBeenDeleted: false)
    @State private var newDeckName: String = ""
    @State private var newFormat: Format = .casual
    @State private var lastWinRate: Double = 0.0
    @State private var deckMatches: Int = 0
    @State private var deckWins: Int = 0
    @State private var deckLoses: Int = 0
    @State private var deckSelected: Deck = Deck(name: "", format: "", hasBeenDeleted: false)
    
    let player: Player
    
    var groupedMatchesByDate: [Date: [SingleMatch]] {
        let filteredMatches = matches.filter { $0.decksID.contains(deckSelected.id) }
        return Dictionary(grouping: filteredMatches) { match in
            Calendar.current.startOfDay(for: match.date)
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Section {
                    DecksList(deckSelected: $deckSelected, player: player)
                } header: {
                    HStack {
                        Text("Decks")
                            .foregroundStyle(.white)
                            .shadowPop()
                        
                        Spacer()
                        
                        Button {
                            addDeck.toggle()
                        } label: {
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                        }
                        .font(.title3)
                        .foregroundStyle(.orange)
                        .shadowPop()
                        
                        Button {
                            showDeletedDecks.toggle()
                        } label: {
                            Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash.fill")
                        }
                        .font(.title3)
                        .foregroundStyle(.white)
                        .shadowPop()
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .background(.black)
                    .shadowPop()
                
                HStack {
                    Spacer()
                    Spacer()
                    
                    Text(deckSelected.name)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        deckToEdit = deckSelected
                        switch deckSelected.format {
                        case "casual": newFormat = .casual
                        case "standard": newFormat = .standard
                        case "modern" : newFormat = .modern
                        case "commander": newFormat = .commander
                        case "vintage": newFormat = .vintage
                        case "legacy": newFormat = .legacy
                        case "pauper": newFormat = .pauper
                        default: newFormat = .casual
                        }
                        editDeck.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                    }
                    .font(.title)
                    .foregroundStyle(.orange)
                    
                    Button {
                        deleteDeck.toggle()
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .foregroundStyle(.red)
                    }
                    .font(.title)
                }
                .padding(.horizontal)
                .shadowPop()
                
                if !groupedMatchesByDate.isEmpty {
                    Section {
                        Chart {
                            ForEach(winRatesData(for: deckSelected), id: \.matchNumber) { dataPoint in
                                LineMark(
                                    x: .value("Match Number", dataPoint.matchNumber),
                                    y: .value("Win Rate", dataPoint.winRate)
                                )
                                .foregroundStyle(.orange)
                            }
                        }
                        .chartXAxis {
                            AxisMarks(position: .bottom, values: .automatic(desiredCount: 5))
                        }
                        .chartYAxis {
                            AxisMarks(values: .stride(by: 10))
                        }
                        .bold()
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.black.opacity(0.6))
                        }
                        .frame(maxHeight: 200)
                        .padding()
                    } header: {
                        HStack {
                            Text("Total matches: \(deckMatches)")
                            Text("Wins: \(deckWins)")
                                .foregroundStyle(.green)
                            Text("Loses: \(deckLoses)")
                                .foregroundStyle(.red)
                            Text("wr: \(lastWinRate, specifier: "%.0f")%")
                                .bold()
                        }
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .shadowPop()
                    }
                    .onChange(of: deckSelected) {
                        updateWinRates()
                    }
                    
                    Section {
                        Section {
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
                                            .padding(.vertical, 2)
                                            .listRowBackground(
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .foregroundStyle(.black.opacity(0.6))
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(lineWidth: 3)
                                                        .foregroundStyle(player.id == match.winnerID ? .green : .red)
                                                }
                                                    .padding(.vertical, 2)
                                                    .shadowPop()
                                            )
                                        }
                                    } header: {
                                        Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                            .foregroundStyle(.white)
                                    }
                                    .shadowPop()
                                }
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.never)
                        }
                        
                    } header: {
                        Text("Latest Matches")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                            .bold()
                            .shadowPop()
                    }
                    .padding(.horizontal)
                } else {
                    ContentUnavailableView(
                        "There are no matches with this deck yet",
                        systemImage: "rectangle.split.2x1.slash.fill",
                        description: Text("Play some games!").foregroundStyle(.white)
                    )
                    .shadowPop()
                }
            }
            .navigationDestination(isPresented: $showDeletedDecks, destination: {
                DeletedDecksView(player: player)
            })
            .alert("Are you sure you want to delete \(deckSelected.name)?", isPresented: $deleteDeck, actions: {
                Button("Yes") {
                    deleteDeck(deck: deckSelected)
                    deckSelected = player.decks.filter({ $0.hasBeenDeleted == false }).first ?? Deck(name: "", format: "", hasBeenDeleted: false)
                }
                
                Button("No", role: .cancel) {}
            }, message: {
                Text("You can undo this action later")
            })
            .blur(radius: editDeck ? 3.0 : 0.0)
            .disabled(editDeck ? true : false)
            .navigationTitle(player.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        player.favorite.toggle()
                    } label: {
                        Image(systemName: player.favorite ? "star.fill" : "star")
                            .foregroundStyle(.orange)
                            .font(.title3)
                    }
                }
            }
            .background {
                Image(uiImage: viewModel.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $addDeck) {
                AddDeckSheet(sheet: $addDeck, player: player)
            }
            
            EditDeckPopUp(newDeckName: $newDeckName, newFormat: $newFormat, editDeck: $editDeck, deckToEdit: $deckToEdit)
                .opacity(editDeck ? 1.0 : 0.0)
        }
        .onAppear {
            deckSelected = player.decks.filter({ $0.hasBeenDeleted == false }).first ?? Deck(name: "", format: "", hasBeenDeleted: false)
        }
    }
    
    func deleteDeck(deck: Deck) {
        deck.hasBeenDeleted = true
    }
    
    func winRatesData(for deck: Deck) -> [WinRateDataPoint] {
        var winRates: [WinRateDataPoint] = []
        var winCount = 0
        var matchCount = 0
        
        for match in matches {
            if match.decksID.contains(deck.id) {
                matchCount += 1
                if match.winnerDeckID == deck.id {
                    winCount += 1
                }
                let winRate = (Double(winCount) / Double(matchCount)) * 100
                winRates.append(WinRateDataPoint(matchNumber: matchCount, winRate: winRate))
            }
        }
        return winRates
    }
    
    func updateWinRates() {
        deckMatches = matches.filter { $0.decksID.contains(deckSelected.id) }.count
        deckWins = matches.filter { $0.winnerDeckID == deckSelected.id }.count
        deckLoses = deckMatches - deckWins
        lastWinRate = deckMatches > 0 ? (Double(deckWins) / Double(deckMatches)) * 100.0 : 0.0
    }
    
    struct WinRateDataPoint {
        var matchNumber: Int
        var winRate: Double
    }
}


