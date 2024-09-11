//
//  Matches.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 29/4/24.
//

import Foundation
import SwiftData

@Model
class SingleMatch: Hashable {
    @Attribute(.unique)  var id = UUID()
    var players: [Player]
    var decks: [Deck]
    var winner: Player
    var winnerDeck: Deck
    var date: Date
    
    init(id: UUID = UUID(), players: [Player], decks: [Deck], winner: Player, winnerDeck: Deck, date: Date) {
        self.id = id
        self.players = players
        self.decks = decks
        self.winner = winner
        self.winnerDeck = winnerDeck
        self.date = date
    }
}
