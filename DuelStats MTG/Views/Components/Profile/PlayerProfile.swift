//
//  PlayerProfile.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 13/9/24.
//

import SwiftUI
import Charts

struct PlayerProfile: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    @State private var editDeck: Bool = false
    @State private var addDeck: Bool = false
    @State private var deleteDeck: Bool = false
    @State private var showDeletedDecks: Bool = false
    @State private var deckToEdit: Deck = Deck(name: "", format: "", hasBeenDeleted: false)
    @State private var newDeckName: String = ""
    @State private var newFormat: Format = .casual
    
    @State private var deckSelected: Deck = Deck(name: "", format: "", hasBeenDeleted: false)
    
    let player: Player
    
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
                        .font(.title2)
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
                
                Spacer()
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
}
