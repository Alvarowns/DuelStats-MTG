//
//  DecksInkeeperList.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI

struct DecksInkeeperList: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    var player: Player
    
    var body: some View {
        List {
            ForEach(player.decks.sorted(by: { $0.format > $1.format }), id: \.self) { deck in
                HStack {
                    Image(systemName: viewModel.isDeckSelected(player: player, deck: deck) ? "circlebadge.fill" : "circlebadge")
                        .foregroundStyle(viewModel.isDeckSelected(player: player, deck: deck) ? .forest : .secondary)
                        .imageScale(.medium)
                    
                    Spacer()
                    
                    HStack {
                        Text(deck.name)
                            .bold()
                        Spacer()
                    }
                    .frame(maxWidth: 150)
                    
                    Spacer()
                    
                    Text("\(deck.format.capitalized)")
                        .frame(maxWidth: 55)
                    
                }
                .onTapGesture {
                    viewModel.changeDeck(player, withDeck: deck)
                }
                .font(.subheadline)
            }
            .onDelete {deleteDeck(at: $0, in: player) }
            
        }
        .listStyle(.plain)
        .frame(height: 125)
    }
    
    
    func deleteDeck(at offsets: IndexSet, in player: Player) {
        for offset in offsets {
            let deck =  player.decks[offset]
            modelContext.delete(deck)
            
        }
        try? modelContext.save()
    }
}
