//
//  PlayerProfile.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 13/9/24.
//

import SwiftUI

struct PlayerProfile: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var editDeck: Bool = false
    @State private var addDeck: Bool = false
    
    let player: Player
    
    var body: some View {
        VStack {
            List {
                ForEach(player.decks, id: \.self) { deck in
                    HStack {
                        Text(deck.name)
                        
                        Button("Edit") {
                            
                        }
                    }
                }
                .onDelete { deleteDeck(at: $0, in: player) }
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle(player.name)
        .sheet(isPresented: $editDeck) {
            AddDeckSheet(sheet: $addDeck, player: player)
        }
    }
    
    func changeDeckName(_ deck: Deck, withName name: String) {
        let newName: String = name
        deck.name = newName
    }
     
    func deleteDeck(at offsets: IndexSet, in player: Player) {
        for offset in offsets {
            let deck =  player.decks[offset]
            modelContext.delete(deck)
            
        }
        try? modelContext.save()
    }
}
