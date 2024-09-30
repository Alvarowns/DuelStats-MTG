//
//  DecksList.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 17/9/24.
//

import SwiftUI

struct DecksList: View {
    @Binding var deckSelected: Deck
    
    var player: Player
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(player.decks.filter({ $0.hasBeenDeleted == false }).sorted(by: { $0.name < $1.name }), id: \.self) { deck in
                    VStack {
                        Text(deck.name)
                            .bold()
                            .font(.headline)
                        Text(deck.format)
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                    .padding(10)
                    .background {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.black.opacity(0.8))
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(deckSelected == deck ? .orange : .black)
                        }
                    }
                    .padding(5)
                    .onTapGesture {
                        deckSelected = deck
                    }
                }
            }
            .padding(.leading)
        }
        .scrollIndicators(.never)
    }
}
